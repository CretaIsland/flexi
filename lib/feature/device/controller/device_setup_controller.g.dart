// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_setup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accessibilityNetworksHash() =>
    r'9e8fb401114b1a3df9a89dfb4626cc155cacd323';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
