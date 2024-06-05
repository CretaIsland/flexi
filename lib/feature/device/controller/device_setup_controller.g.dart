// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_setup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accessibilityNetworksHash() =>
    r'f028c74fdd153af1f29a51a9180ffbafc6c6ad37';

/// See also [accessibilityNetworks].
@ProviderFor(accessibilityNetworks)
final accessibilityNetworksProvider =
    AutoDisposeFutureProvider<Stream<List<NetworkInfo>>>.internal(
  accessibilityNetworks,
  name: r'accessibilityNetworksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accessibilityNetworksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccessibilityNetworksRef
    = AutoDisposeFutureProviderRef<Stream<List<NetworkInfo>>>;
String _$networkControllerHash() => r'9566381569ad778937955b1570d904c3f2cdeadf';

/// See also [NetworkController].
@ProviderFor(NetworkController)
final networkControllerProvider =
    AutoDisposeNotifierProvider<NetworkController, String?>.internal(
  NetworkController.new,
  name: r'networkControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NetworkController = AutoDisposeNotifier<String?>;
String _$wifiCredentialsControllerHash() =>
    r'6d04f1a4162080ec9854e93d31211295b42f4058';

/// See also [WifiCredentialsController].
@ProviderFor(WifiCredentialsController)
final wifiCredentialsControllerProvider = AutoDisposeNotifierProvider<
    WifiCredentialsController, Map<String, String>>.internal(
  WifiCredentialsController.new,
  name: r'wifiCredentialsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wifiCredentialsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WifiCredentialsController = AutoDisposeNotifier<Map<String, String>>;
String _$localStorageControllerHash() =>
    r'c11bd9a8a95a8b5bc717324f69a78a0a6cdb69b5';

/// See also [LocalStorageController].
@ProviderFor(LocalStorageController)
final localStorageControllerProvider = AutoDisposeNotifierProvider<
    LocalStorageController, List<AssetEntity>>.internal(
  LocalStorageController.new,
  name: r'localStorageControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localStorageControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocalStorageController = AutoDisposeNotifier<List<AssetEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
