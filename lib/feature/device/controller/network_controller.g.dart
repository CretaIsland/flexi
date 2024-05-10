// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkStreamHash() => r'e06f74497c3d94cedcdb0c7f2c1c96e89a7079a2';

/// See also [networkStream].
@ProviderFor(networkStream)
final networkStreamProvider =
    AutoDisposeFutureProvider<Stream<List<NetworkInfo>>>.internal(
  networkStream,
  name: r'networkStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NetworkStreamRef
    = AutoDisposeFutureProviderRef<Stream<List<NetworkInfo>>>;
String _$currentNetworkInfoHash() =>
    r'0b6bf542a8d5be070d308528ff8696b9362cf987';

/// See also [currentNetworkInfo].
@ProviderFor(currentNetworkInfo)
final currentNetworkInfoProvider = AutoDisposeProvider<NetworkInfo?>.internal(
  currentNetworkInfo,
  name: r'currentNetworkInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentNetworkInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentNetworkInfoRef = AutoDisposeProviderRef<NetworkInfo?>;
String _$networkControllerHash() => r'5001ca313914a177c3e7d33bb225fe6ba55c3ea2';

/// See also [NetworkController].
@ProviderFor(NetworkController)
final networkControllerProvider =
    AutoDisposeNotifierProvider<NetworkController, void>.internal(
  NetworkController.new,
  name: r'networkControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NetworkController = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
