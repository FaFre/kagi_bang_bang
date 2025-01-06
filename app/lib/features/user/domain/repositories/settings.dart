import 'dart:async';

import 'package:drift/drift.dart';
import 'package:lensai/features/user/data/database/database.dart';
import 'package:lensai/features/user/data/models/settings.dart';
import 'package:lensai/features/user/data/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.g.dart';

typedef UpdateSettingsFunc = Settings Function(Settings currentSettings);

@Riverpod(keepAlive: true)
class SettingsRepository extends _$SettingsRepository {
  late UserDatabase _db;

  Future<void> updateSettings(UpdateSettingsFunc updateWithCurrent) {
    final oldJson = state.toJson();
    final newJson = updateWithCurrent(state).toJson();

    return _db.transaction(() async {
      for (final MapEntry(:key, :value) in newJson.entries) {
        if (oldJson[key] != value) {
          await _db.settingDao.updateSetting(key, value);
        }
      }
    });
  }

  @override
  Settings build() {
    _db = ref.watch(userDatabaseProvider);

    final watchSub = _db.settingDao.allSettings().watch().listen((entries) {
      final settings = Map.fromEntries(entries);

      state = Settings.fromJson({
        'incognitoMode': settings['incognitoMode']
            ?.readAs(DriftSqlType.bool, _db.typeMapping),
        'enableJavascript': settings['enableJavascript']
            ?.readAs(DriftSqlType.bool, _db.typeMapping),
        'blockHttpProtocol': settings['blockHttpProtocol']
            ?.readAs(DriftSqlType.bool, _db.typeMapping),
        'themeMode':
            settings['themeMode']?.readAs(DriftSqlType.string, _db.typeMapping),
        'enableReadability': settings['enableReadability']
            ?.readAs(DriftSqlType.bool, _db.typeMapping),
      });
    });

    ref.onDispose(() {
      unawaited(watchSub.cancel());
    });

    return Settings.withDefaults();
  }
}
