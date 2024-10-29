// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$unusedRandomContainerColorHash() =>
    r'913499b3de281ea0020db97ed67121652f53ec08';

/// See also [unusedRandomContainerColor].
@ProviderFor(unusedRandomContainerColor)
final unusedRandomContainerColorProvider =
    AutoDisposeFutureProvider<Color>.internal(
  unusedRandomContainerColor,
  name: r'unusedRandomContainerColorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unusedRandomContainerColorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnusedRandomContainerColorRef = AutoDisposeFutureProviderRef<Color>;
String _$containersWithCountHash() =>
    r'ee0734e4b71472b79636816616a158f54fa6bc23';

/// See also [containersWithCount].
@ProviderFor(containersWithCount)
final containersWithCountProvider =
    AutoDisposeStreamProvider<List<ContainerDataWithCount>>.internal(
  containersWithCount,
  name: r'containersWithCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$containersWithCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContainersWithCountRef
    = AutoDisposeStreamProviderRef<List<ContainerDataWithCount>>;
String _$tabContainerIdHash() => r'726ddd000d23935a2c8ae39c7957412fab16016d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [tabContainerId].
@ProviderFor(tabContainerId)
const tabContainerIdProvider = TabContainerIdFamily();

/// See also [tabContainerId].
class TabContainerIdFamily extends Family<AsyncValue<String?>> {
  /// See also [tabContainerId].
  const TabContainerIdFamily();

  /// See also [tabContainerId].
  TabContainerIdProvider call(
    String tabId,
  ) {
    return TabContainerIdProvider(
      tabId,
    );
  }

  @override
  TabContainerIdProvider getProviderOverride(
    covariant TabContainerIdProvider provider,
  ) {
    return call(
      provider.tabId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tabContainerIdProvider';
}

/// See also [tabContainerId].
class TabContainerIdProvider extends AutoDisposeStreamProvider<String?> {
  /// See also [tabContainerId].
  TabContainerIdProvider(
    String tabId,
  ) : this._internal(
          (ref) => tabContainerId(
            ref as TabContainerIdRef,
            tabId,
          ),
          from: tabContainerIdProvider,
          name: r'tabContainerIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tabContainerIdHash,
          dependencies: TabContainerIdFamily._dependencies,
          allTransitiveDependencies:
              TabContainerIdFamily._allTransitiveDependencies,
          tabId: tabId,
        );

  TabContainerIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tabId,
  }) : super.internal();

  final String tabId;

  @override
  Override overrideWith(
    Stream<String?> Function(TabContainerIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TabContainerIdProvider._internal(
        (ref) => create(ref as TabContainerIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tabId: tabId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<String?> createElement() {
    return _TabContainerIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TabContainerIdProvider && other.tabId == tabId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tabId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TabContainerIdRef on AutoDisposeStreamProviderRef<String?> {
  /// The parameter `tabId` of this provider.
  String get tabId;
}

class _TabContainerIdProviderElement
    extends AutoDisposeStreamProviderElement<String?> with TabContainerIdRef {
  _TabContainerIdProviderElement(super.provider);

  @override
  String get tabId => (origin as TabContainerIdProvider).tabId;
}

String _$containerTabIdsHash() => r'7545a6c500b1832bf81c0838e257dfe5e051463d';

/// See also [containerTabIds].
@ProviderFor(containerTabIds)
const containerTabIdsProvider = ContainerTabIdsFamily();

/// See also [containerTabIds].
class ContainerTabIdsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [containerTabIds].
  const ContainerTabIdsFamily();

  /// See also [containerTabIds].
  ContainerTabIdsProvider call(
    String? containerId,
  ) {
    return ContainerTabIdsProvider(
      containerId,
    );
  }

  @override
  ContainerTabIdsProvider getProviderOverride(
    covariant ContainerTabIdsProvider provider,
  ) {
    return call(
      provider.containerId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'containerTabIdsProvider';
}

/// See also [containerTabIds].
class ContainerTabIdsProvider extends AutoDisposeStreamProvider<List<String>> {
  /// See also [containerTabIds].
  ContainerTabIdsProvider(
    String? containerId,
  ) : this._internal(
          (ref) => containerTabIds(
            ref as ContainerTabIdsRef,
            containerId,
          ),
          from: containerTabIdsProvider,
          name: r'containerTabIdsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$containerTabIdsHash,
          dependencies: ContainerTabIdsFamily._dependencies,
          allTransitiveDependencies:
              ContainerTabIdsFamily._allTransitiveDependencies,
          containerId: containerId,
        );

  ContainerTabIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.containerId,
  }) : super.internal();

  final String? containerId;

  @override
  Override overrideWith(
    Stream<List<String>> Function(ContainerTabIdsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ContainerTabIdsProvider._internal(
        (ref) => create(ref as ContainerTabIdsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        containerId: containerId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<String>> createElement() {
    return _ContainerTabIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ContainerTabIdsProvider && other.containerId == containerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, containerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ContainerTabIdsRef on AutoDisposeStreamProviderRef<List<String>> {
  /// The parameter `containerId` of this provider.
  String? get containerId;
}

class _ContainerTabIdsProviderElement
    extends AutoDisposeStreamProviderElement<List<String>>
    with ContainerTabIdsRef {
  _ContainerTabIdsProviderElement(super.provider);

  @override
  String? get containerId => (origin as ContainerTabIdsProvider).containerId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
