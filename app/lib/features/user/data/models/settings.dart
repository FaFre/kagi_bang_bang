import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: true, constructor: 'withDefaults')
class Settings with FastEquatable {
  final bool incognitoMode;
  final bool enableJavascript;
  final bool blockHttpProtocol;
  final ThemeMode themeMode;
  final bool enableReadability;

  Settings({
    required this.incognitoMode,
    required this.enableJavascript,
    required this.blockHttpProtocol,
    required this.themeMode,
    required this.enableReadability,
  });

  Settings.withDefaults({
    bool? incognitoMode,
    bool? enableJavascript,
    bool? blockHttpProtocol,
    ThemeMode? themeMode,
    bool? enableReadability,
  })  : incognitoMode = incognitoMode ?? true,
        enableJavascript = enableJavascript ?? true,
        blockHttpProtocol = blockHttpProtocol ?? false,
        themeMode = themeMode ?? ThemeMode.dark,
        enableReadability = enableReadability ?? true;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        incognitoMode,
        enableJavascript,
        blockHttpProtocol,
        themeMode,
        enableReadability,
      ];
}
