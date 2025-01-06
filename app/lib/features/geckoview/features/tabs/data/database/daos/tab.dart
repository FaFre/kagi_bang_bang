import 'dart:async';

import 'package:drift/drift.dart';
import 'package:lensai/features/geckoview/domain/entities/tab_state.dart';
import 'package:lensai/features/geckoview/features/tabs/data/database/database.dart';
import 'package:lensai/features/geckoview/features/tabs/data/models/tab_query_result.dart';
import 'package:lexo_rank/lexo_rank.dart';

part 'tab.g.dart';

@DriftAccessor()
class TabDao extends DatabaseAccessor<TabDatabase> with _$TabDaoMixin {
  TabDao(super.db);

  UpdateStatement<Tab, TabData> _updateByIdStatement(String id) =>
      db.tab.update()..where((t) => t.id.equals(id));

  Selectable<TabData> allTabData() => db.tab.select();

  SingleOrNullSelectable<TabData> tabDataById(String id) =>
      db.tab.select()..where((t) => t.id.equals(id));

  Selectable<String> containerTabIds(String? containerId) {
    final query = selectOnly(db.tab)
      ..addColumns([db.tab.id])
      ..where(
        (containerId != null)
            ? db.tab.containerId.equals(containerId)
            : db.tab.containerId.isNull(),
      )
      ..orderBy([OrderingTerm.asc(db.tab.orderKey)]);

    return query.map((row) => row.read(db.tab.id)!);
  }

  Selectable<String> allTabIds() {
    final query = selectOnly(db.tab)
      ..addColumns([db.tab.id])
      ..orderBy([OrderingTerm.asc(db.tab.orderKey)]);

    return query.map((row) => row.read(db.tab.id)!);
  }

  SingleSelectable<String?> tabContainerId(String tabId) {
    final query = selectOnly(db.tab)
      ..addColumns([db.tab.containerId])
      ..where(db.tab.id.equals(tabId));

    return query.map((row) => row.read(db.tab.containerId));
  }

  Future<String> upsertTab(
    String tabId, {
    Value<String?> containerId = const Value.absent(),
    Value<String?> orderKey = const Value.absent(),
  }) {
    return db.transaction(() async {
      final currentOrderKey = orderKey.value ??
          await db.containerDao
              .generateLeadingOrderKey(containerId.value)
              .getSingle();

      await db.tab.insertOne(
        TabCompanion.insert(
          id: tabId,
          timestamp: DateTime.now(),
          containerId: containerId,
          orderKey: currentOrderKey,
        ),
        onConflict: DoUpdate(
          (old) => TabCompanion.custom(
            containerId:
                (containerId.present) ? Variable(containerId.value) : null,
            orderKey: (orderKey.present) ? Variable(orderKey.value) : null,
          ),
        ),
      );

      return tabId;
    });
  }

  Future<void> assignContainer(
    String id, {
    required String? containerId,
  }) {
    final statement = _updateByIdStatement(id);
    return statement.write(
      TabCompanion(containerId: Value(containerId)),
    );
  }

  Future<void> assignOrderKey(
    String id, {
    required String orderKey,
  }) {
    final statement = _updateByIdStatement(id);
    return statement.write(
      TabCompanion(orderKey: Value(orderKey)),
    );
  }

  Future<void> touchTab(
    String id, {
    required DateTime timestamp,
  }) {
    final statement = _updateByIdStatement(id);
    return statement.write(
      TabCompanion(timestamp: Value(timestamp)),
    );
  }

  Future<void> updateTab(
    String id, {
    Value<String?> url = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<String?> extractedContentMarkdown = const Value.absent(),
    Value<String?> extractedContentPlain = const Value.absent(),
    Value<String?> fullContentMarkdown = const Value.absent(),
    Value<String?> fullContentPlain = const Value.absent(),
  }) async {
    final doUpdate = url != const Value.absent() ||
        title != const Value.absent() ||
        extractedContentMarkdown != const Value.absent() ||
        extractedContentPlain != const Value.absent() ||
        fullContentMarkdown != const Value.absent() ||
        fullContentPlain != const Value.absent();

    if (doUpdate) {
      final statement = _updateByIdStatement(id);
      await statement.write(
        TabCompanion(
          url: url,
          title: title,
          extractedContentMarkdown: extractedContentMarkdown,
          extractedContentPlain: extractedContentPlain,
          fullContentMarkdown: fullContentMarkdown,
          fullContentPlain: fullContentPlain,
        ),
      );
    }
  }

  Future<void> updateTabs(
    Map<String, TabState>? previous,
    Map<String, TabState> next,
  ) async {
    await batch((batch) async {
      for (final state in next.values) {
        final previousState = previous?[state.id];

        if (previousState == null ||
            previousState.url != state.url ||
            previousState.title != state.title) {
          batch.update(
            db.tab,
            TabCompanion(
              url: (previousState?.url != state.url)
                  ? Value(state.url.toString())
                  : const Value.absent(),
              title: (previousState?.title != state.title)
                  ? Value(state.title)
                  : const Value.absent(),
            ),
            where: (t) => t.id.equals(state.id),
          );
        }
      }
    });
  }

  Future<void> syncTabs({required List<String> retainTabIds}) async {
    return db.transaction(() async {
      await (db.tab.delete()..where((t) => t.id.isNotIn(retainTabIds))).go();

      var currentOrderKey =
          await db.containerDao.generateLeadingOrderKey(null).getSingle();

      await db.tab.insertAll(
        retainTabIds.map(
          (id) {
            final insertable = TabCompanion.insert(
              id: id,
              orderKey: currentOrderKey,
              timestamp: DateTime.now(),
            );

            currentOrderKey = LexoRank.parse(currentOrderKey).genPrev().value;

            return insertable;
          },
        ),
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Selectable<TabQueryResult> queryTabs({
    required String matchPrefix,
    required String matchSuffix,
    required String ellipsis,
    required int snippetLength,
    required String searchString,
  }) {
    final ftsQuery = db.buildFtsQuery(searchString);

    if (ftsQuery.isNotEmpty) {
      return db.queryTabsFullContent(
        query: db.buildFtsQuery(searchString),
        snippetLength: snippetLength,
        beforeMatch: matchPrefix,
        afterMatch: matchSuffix,
        ellipsis: ellipsis,
      );
    } else {
      return db.queryTabsBasic(
        query: db.buildLikeQuery(searchString),
        beforeMatch: matchPrefix,
        afterMatch: matchSuffix,
      );
    }
  }
}
