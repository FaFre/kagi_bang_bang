// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SettingsCWProxy {
  Settings incognitoMode(bool incognitoMode);

  Settings enableJavascript(bool enableJavascript);

  Settings blockHttpProtocol(bool blockHttpProtocol);

  Settings themeMode(ThemeMode themeMode);

  Settings enableReadability(bool enableReadability);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Settings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Settings(...).copyWith(id: 12, name: "My name")
  /// ````
  Settings call({
    bool incognitoMode,
    bool enableJavascript,
    bool blockHttpProtocol,
    ThemeMode themeMode,
    bool enableReadability,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSettings.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSettings.copyWith.fieldName(...)`
class _$SettingsCWProxyImpl implements _$SettingsCWProxy {
  const _$SettingsCWProxyImpl(this._value);

  final Settings _value;

  @override
  Settings incognitoMode(bool incognitoMode) =>
      this(incognitoMode: incognitoMode);

  @override
  Settings enableJavascript(bool enableJavascript) =>
      this(enableJavascript: enableJavascript);

  @override
  Settings blockHttpProtocol(bool blockHttpProtocol) =>
      this(blockHttpProtocol: blockHttpProtocol);

  @override
  Settings themeMode(ThemeMode themeMode) => this(themeMode: themeMode);

  @override
  Settings enableReadability(bool enableReadability) =>
      this(enableReadability: enableReadability);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Settings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Settings(...).copyWith(id: 12, name: "My name")
  /// ````
  Settings call({
    Object? incognitoMode = const $CopyWithPlaceholder(),
    Object? enableJavascript = const $CopyWithPlaceholder(),
    Object? blockHttpProtocol = const $CopyWithPlaceholder(),
    Object? themeMode = const $CopyWithPlaceholder(),
    Object? enableReadability = const $CopyWithPlaceholder(),
  }) {
    return Settings(
      incognitoMode: incognitoMode == const $CopyWithPlaceholder()
          ? _value.incognitoMode
          // ignore: cast_nullable_to_non_nullable
          : incognitoMode as bool,
      enableJavascript: enableJavascript == const $CopyWithPlaceholder()
          ? _value.enableJavascript
          // ignore: cast_nullable_to_non_nullable
          : enableJavascript as bool,
      blockHttpProtocol: blockHttpProtocol == const $CopyWithPlaceholder()
          ? _value.blockHttpProtocol
          // ignore: cast_nullable_to_non_nullable
          : blockHttpProtocol as bool,
      themeMode: themeMode == const $CopyWithPlaceholder()
          ? _value.themeMode
          // ignore: cast_nullable_to_non_nullable
          : themeMode as ThemeMode,
      enableReadability: enableReadability == const $CopyWithPlaceholder()
          ? _value.enableReadability
          // ignore: cast_nullable_to_non_nullable
          : enableReadability as bool,
    );
  }
}

extension $SettingsCopyWith on Settings {
  /// Returns a callable class that can be used as follows: `instanceOfSettings.copyWith(...)` or like so:`instanceOfSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SettingsCWProxy get copyWith => _$SettingsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings.withDefaults(
      incognitoMode: json['incognitoMode'] as bool?,
      enableJavascript: json['enableJavascript'] as bool?,
      blockHttpProtocol: json['blockHttpProtocol'] as bool?,
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']),
      enableReadability: json['enableReadability'] as bool?,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'incognitoMode': instance.incognitoMode,
      'enableJavascript': instance.enableJavascript,
      'blockHttpProtocol': instance.blockHttpProtocol,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'enableReadability': instance.enableReadability,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
