// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectionActionServiceHash() =>
    r'd0c04262171976c21441297706273417e3d79b67';

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
String _$tabContentServiceHash() => r'd9a991add907ecc138c62790883e59d8e9aa9266';

/// See also [tabContentService].
@ProviderFor(tabContentService)
final tabContentServiceProvider = Provider<GeckoTabContentService>.internal(
  tabContentService,
  name: r'tabContentServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tabContentServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TabContentServiceRef = ProviderRef<GeckoTabContentService>;
String _$selectedTabSessionNotifierHash() =>
    r'aef19991d5b05a2bb28e8a6ccb57dc75c2f3148f';

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
