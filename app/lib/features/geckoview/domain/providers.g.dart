// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectionActionServiceHash() =>
    r'c150f6003dcea80b18fc063dd998ab45ce27d1a1';

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

typedef SelectionActionServiceRef = ProviderRef<GeckoSelectionActionService>;
String _$eventServiceHash() => r'5aa357fdf0d217677a9a66ecb50417ac18929cad';

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

typedef EventServiceRef = ProviderRef<GeckoEventService>;
String _$selectedTabSessionNotifierHash() =>
    r'ea9959e871dd0c3a8b80152eafe726c925094106';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
