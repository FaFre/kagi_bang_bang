import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:exceptions/exceptions.dart';
import 'package:lensai/domain/services/generic_website.dart';
import 'package:lensai/features/bangs/data/database/database.dart';
import 'package:lensai/features/bangs/data/models/bang.dart';
import 'package:lensai/features/bangs/data/models/bang_data.dart';
import 'package:lensai/features/bangs/data/models/search_history_entry.dart';
import 'package:lensai/features/bangs/data/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data.g.dart';

@Riverpod(keepAlive: true)
class BangDataRepository extends _$BangDataRepository {
  late BangDatabase _db;

  @override
  void build() {
    _db = ref.watch(bangDatabaseProvider);
  }

  Stream<BangData?> watchBang(String? trigger) {
    if (trigger != null) {
      return _db.bangDao.getBangData(trigger).watchSingleOrNull();
    } else {
      return Stream.value(null);
    }
  }

  Stream<Map<String, List<String>>> watchCategories() {
    return _db.categoriesJson().watchSingle().map((json) {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map(
        (key, value) => MapEntry(key, (value as List<dynamic>).cast()),
      );
    });
  }

  Stream<int> watchBangCount(BangGroup group) {
    return _db.bangDao.getBangCount(groups: [group]).watchSingle();
  }

  Stream<List<BangData>> watchBangs({
    Iterable<BangGroup>? groups,
    String? domain,
    ({String category, String? subCategory})? categoryFilter,
    bool? orderMostFrequentFirst,
  }) {
    return _db.bangDao
        .getBangDataList(
          groups: groups,
          domain: domain,
          category: categoryFilter?.category,
          subCategory: categoryFilter?.subCategory,
          orderMostFrequentFirst: orderMostFrequentFirst,
        )
        .watch();
  }

  Stream<List<BangData>> watchFrequentBangs({Iterable<BangGroup>? groups}) {
    return _db.bangDao.getFrequentBangDataList(groups: groups).watch();
  }

  Stream<List<SearchHistoryEntry>> watchSearchHistory({required int limit}) {
    return _db.searchHistoryEntries(limit: limit).watch();
  }

  Future<void> increaseFrequency(String trigger) {
    return _db.bangDao.increaseBangFrequency(trigger);
  }

  Future<void> addSearchEntry(
    String trigger,
    String searchQuery, {
    required int maxEntryCount,
  }) {
    //Pack in a transaction to bundle rebuilds of watch() queries
    return _db.transaction(
      () async {
        await _db.bangDao.addSearchEntry(trigger, searchQuery);
        await _db.evictHistoryEntries(limit: maxEntryCount);
      },
    );
  }

  Future<void> removeSearchEntry(String searchQuery) {
    return _db.bangDao.removeSearchEntry(searchQuery);
  }

  Future<Result<BangData>> ensureIconAvailable(BangData bang) async {
    if (bang.icon != null) {
      return Result.success(bang);
    }

    final url = bang.getUrl('');

    final websiteProvider = ref.read(genericWebsiteServiceProvider.notifier);
    final cachedIcon = await websiteProvider.getCachedIcon(url);

    if (cachedIcon != null) {
      return Result.success(bang.copyWith.icon(cachedIcon));
    }

    return websiteProvider.fetchPageInfo(url).then(
          (result) => result
              .flatMap((pageInfo) => bang.copyWith.icon(pageInfo.favicon)),
        );
  }

  Future<int> resetFrequencies() {
    return _db.bangFrequency.deleteAll();
  }

  Future<int> resetFrequency(String trigger) {
    return _db.bangFrequency.deleteWhere((t) => t.trigger.equals(trigger));
  }
}
