// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectionActionServiceHash() =>
    r'b5bc6b2bc5496ae84d61a74cc6ff052b55d2a3d3';

/// See also [selectionActionService].
@ProviderFor(selectionActionService)
final selectionActionServiceProvider =
    Provider<GeckoSelectionActionService>.internal(
  selectionActionService,
  name: r'selectionActionServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectionActionServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectionActionServiceRef = ProviderRef<GeckoSelectionActionService>;
String _$eventServiceHash() => r'166b01f636fbdd4355dbc55a18ca4f83e0006de8';

/// See also [eventService].
@ProviderFor(eventService)
final eventServiceProvider = Provider<GeckoEventService>.internal(
  eventService,
  name: r'eventServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$eventServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventServiceRef = ProviderRef<GeckoEventService>;
String _$addonServiceHash() => r'c7aca09b99c3810908176f3464f5f90a185aa5e7';

/// See also [addonService].
@ProviderFor(addonService)
final addonServiceProvider = Provider<GeckoAddonService>.internal(
  addonService,
  name: r'addonServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$addonServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AddonServiceRef = ProviderRef<GeckoAddonService>;
String _$selectedTabSessionNotifierHash() =>
    r'62fcd98a915566d55b5bcb297d87d675fe12786d';

/// See also [selectedTabSessionNotifier].
@ProviderFor(selectedTabSessionNotifier)
final selectedTabSessionNotifierProvider =
    AutoDisposeProvider<Raw<TabSession>>.internal(
  selectedTabSessionNotifier,
  name: r'selectedTabSessionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedTabSessionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedTabSessionNotifierRef = AutoDisposeProviderRef<Raw<TabSession>>;
String _$engineReadyStateHash() => r'c682333e2e07cf0635aa7ae793a2088ca648c950';

/// See also [EngineReadyState].
@ProviderFor(EngineReadyState)
final engineReadyStateProvider =
    NotifierProvider<EngineReadyState, bool>.internal(
  EngineReadyState.new,
  name: r'engineReadyStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$engineReadyStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EngineReadyState = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
