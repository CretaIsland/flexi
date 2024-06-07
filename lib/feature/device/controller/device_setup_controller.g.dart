// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_setup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accessibilityNetworksHash() =>
    r'8ac065c7c0b7c20d6195da872ec6370019c96bf3';

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
String _$networkControllerHash() => r'b5250b5e96b8b122055f1bd9b6770dc7e28c96c9';

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
    r'35c579dd693939e42e6bef3308b87256f5060578';

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
    r'd9acd7c0bc07ebe1625f8eb0ead5cb37d6f2028d';

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
