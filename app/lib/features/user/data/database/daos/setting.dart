import 'package:drift/drift.dart';
import 'package:lensai/features/user/data/database/database.dart';

part 'setting.g.dart';

@DriftAccessor()
class SettingDao extends DatabaseAccessor<UserDatabase> with _$SettingDaoMixin {
  SettingDao(super.attachedDatabase);

  Future<int> updateSetting(String key, Object? value) {
    final driftvalue = (value != null) ? DriftAny(value) : null;

    return db.setting.insertOne(
      SettingCompanion.insert(
        key: key,
        value: Value(driftvalue),
      ),
      onConflict: DoUpdate(
        (old) => SettingCompanion.custom(value: Variable(driftvalue)),
      ),
    );
  }

  Selectable<MapEntry<String, DriftAny?>> allSettings() {
    return db.setting.select().map((row) => MapEntry(row.key, row.value));
  }
}
