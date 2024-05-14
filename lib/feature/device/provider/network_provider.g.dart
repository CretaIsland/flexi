// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkStreamHash() => r'3b7767a487928afc9fc5d54f48b6c5d55fae63cb';

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
String _$networkChangeHash() => r'90a3dac7d32d37272ba77b16e193ab5216498bc5';

/// See also [networkChange].
@ProviderFor(networkChange)
final networkChangeProvider =
    AutoDisposeStreamProvider<List<ConnectivityResult>>.internal(
  networkChange,
  name: r'networkChangeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkChangeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NetworkChangeRef
    = AutoDisposeStreamProviderRef<List<ConnectivityResult>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
