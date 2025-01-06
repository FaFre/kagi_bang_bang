import 'dart:async';

import 'package:lensai/features/geckoview/features/tabs/data/database/database.dart';
import 'package:lensai/features/geckoview/features/tabs/data/models/tab_query_result.dart';
import 'package:lensai/features/geckoview/features/tabs/data/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tab_search.g.dart';

@Riverpod()
class TabSearchRepository extends _$TabSearchRepository {
  late TabDatabase _db;

  Future<void> addQuery(
    String input, {
    int snippetLength = 120,
    String matchPrefix = '***',
    String matchSuffix = '***',
    String ellipsis = '…',
  }) async {
    if (input.isNotEmpty) {
      state = await AsyncValue.guard(
        () => _db.tabDao
            .queryTabs(
              matchPrefix: matchPrefix,
              matchSuffix: matchSuffix,
              ellipsis: ellipsis,
              snippetLength: snippetLength,
              searchString: input,
            )
            .get(),
      );
    } else {
      state = const AsyncValue.data(null);
    }
  }

  @override
  Future<List<TabQueryResult>?> build() {
    _db = ref.watch(tabDatabaseProvider);

    return Future.value();
  }
}
