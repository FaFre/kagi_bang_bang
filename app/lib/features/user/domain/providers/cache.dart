import 'package:lensai/features/user/data/providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache.g.dart';

@Riverpod()
Stream<double> iconCacheSizeMegabytes(Ref ref) {
  final repository = ref.watch(userDatabaseProvider);
  return repository.cacheDao.iconCacheSize().watchSingle();
}
