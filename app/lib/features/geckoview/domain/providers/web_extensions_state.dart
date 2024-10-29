import 'dart:async';
import 'dart:ui';

import 'package:flutter_mozilla_components/flutter_mozilla_components.dart';
import 'package:lensai/domain/entities/equatable_image.dart';
import 'package:lensai/extensions/image.dart';
import 'package:lensai/features/geckoview/domain/entities/web_extension_state.dart';
import 'package:lensai/features/geckoview/domain/providers.dart';
import 'package:lensai/features/geckoview/utils/image_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synchronized/synchronized.dart';

part 'web_extensions_state.g.dart';

@Riverpod(keepAlive: true)
class WebExtensionsState extends _$WebExtensionsState {
  final _imageCache = <String, EquatableImage>{};

  final _lock = Lock();

  void _onExtensionUpdate(ExtensionDataEvent event) {
    final ExtensionDataEvent(:extensionId, :data) = event;

    if (data != null) {
      final current = state[extensionId] ??
          WebExtensionState(
            extensionId: extensionId,
            icon: _imageCache[extensionId],
            enabled: false,
          );

      state = {...state}..[extensionId] = current.copyWith(
          title: data.title,
          enabled: data.enabled,
          badgeText: data.badgeText,
          badgeTextColor: (data.badgeTextColor != null)
              ? Color(data.badgeTextColor!)
              : null,
          badgeBackgroundColor: (data.badgeBackgroundColor != null)
              ? Color(data.badgeBackgroundColor!)
              : null,
        );
    } else {
      if (state.containsKey(extensionId)) {
        state = {...state}..remove(extensionId);
      }
    }
  }

  Future<void> _onIconChange(ExtensionIconEvent event) async {
    final ExtensionIconEvent(:extensionId, :bytes) = event;

    final image =
        await tryDecodeImage(bytes).then((image) async => image?.toEquatable());

    if (image != null) {
      if (_imageCache[extensionId] != image) {
        _imageCache[extensionId] = image;

        if (state.containsKey(extensionId)) {
          state = {...state}..[extensionId] =
              state[extensionId]!.copyWith.icon(image);
        }
      }
    }
  }

  @override
  Map<String, WebExtensionState> build(WebExtensionActionType actionType) {
    final addonService = ref.watch(addonServiceProvider);

    final subscriptions = switch (actionType) {
      WebExtensionActionType.browser => [
          addonService.browserExtensionStream.listen(
            (event) async {
              await _lock.synchronized(() => _onExtensionUpdate(event));
            },
          ),
          addonService.browserIconStream.listen(
            (event) async {
              await _lock.synchronized(() => _onIconChange(event));
            },
          ),
        ],
      WebExtensionActionType.page => [
          addonService.pageExtensionStream.listen(
            (event) async {
              await _lock.synchronized(() => _onExtensionUpdate(event));
            },
          ),
          addonService.pageIconStream.listen(
            (event) async {
              await _lock.synchronized(() => _onIconChange(event));
            },
          ),
        ],
    };

    ref.onDispose(() {
      for (final sub in subscriptions) {
        unawaited(sub.cancel());
      }
    });

    return {};
  }
}
