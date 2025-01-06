import 'package:drift/drift.dart';
import 'package:lensai/extensions/database_table_size.dart';
import 'package:lensai/features/user/data/database/database.dart';

part 'cache.g.dart';

@DriftAccessor()
class CacheDao extends DatabaseAccessor<UserDatabase> with _$CacheDaoMixin {
  CacheDao(super.attachedDatabase);

  SingleSelectable<double> iconCacheSize() {
    return db.tableSize(db.iconCache);
  }

  Future<int> clearIconCache() {
    return db.iconCache.deleteAll();
  }

  SingleOrNullSelectable<Uint8List?> getCachedIcon(String origin) {
    final query = selectOnly(db.iconCache)
      ..addColumns([db.iconCache.iconData])
      ..where(db.iconCache.origin.equals(origin));

    return query.map((row) => row.read(db.iconCache.iconData));
  }

  Future<int> cacheIcon(String origin, Uint8List bytes) {
    return db.iconCache.insertOne(
      IconCacheCompanion.insert(
        origin: origin,
        iconData: bytes,
        fetchDate: DateTime.now(),
      ),
      onConflict: DoUpdate(
        (old) => IconCacheCompanion.custom(
          iconData: Variable(bytes),
          fetchDate: Variable(DateTime.now()),
        ),
      ),
    );
  }
}
