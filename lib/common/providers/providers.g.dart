// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$internetConnectionHash() =>
    r'f67c16677fdb446b657050f54051bb35f458dd1c';

/// See also [internetConnection].
@ProviderFor(internetConnection)
final internetConnectionProvider =
    AutoDisposeStreamProvider<InternetStatus>.internal(
  internetConnection,
  name: r'internetConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$internetConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InternetConnectionRef = AutoDisposeStreamProviderRef<InternetStatus>;
String _$networkChangeHash() => r'f4065fc5b5f5b5e7b382ee8ab091f560222d576b';

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
String _$ipHash() => r'78286999eae44df4bdd0ec7d373297b2d850c4d4';

/// See also [ip].
@ProviderFor(ip)
final ipProvider = AutoDisposeFutureProvider<InternetAddress?>.internal(
  ip,
  name: r'ipProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ipHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IpRef = AutoDisposeFutureProviderRef<InternetAddress?>;
String _$networkInfoHash() => r'843113dd8a098875c341fb9d85ee5f139aae3e00';

/// See also [networkInfo].
@ProviderFor(networkInfo)
final networkInfoProvider = AutoDisposeFutureProvider<
    ({
      String? wifiName,
      String? wifiBSSID,
      String? wifiIP,
      String? wifiIPv6,
      String? wifiSubmask,
      String? wifiBroadcast,
      String? wifiGateway
    })?>.internal(
  networkInfo,
  name: r'networkInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$networkInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NetworkInfoRef = AutoDisposeFutureProviderRef<
    ({
      String? wifiName,
      String? wifiBSSID,
      String? wifiIP,
      String? wifiIPv6,
      String? wifiSubmask,
      String? wifiBroadcast,
      String? wifiGateway
    })?>;
String _$wifisHash() => r'7c14ca6aaf5dc351d2e1ab7e3f0f6ead93401a3e';

/// See also [wifis].
@ProviderFor(wifis)
final wifisProvider = AutoDisposeFutureProvider<List<WifiNetworkInfo>>.internal(
  wifis,
  name: r'wifisProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$wifisHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WifisRef = AutoDisposeFutureProviderRef<List<WifiNetworkInfo>>;
String _$wifisStreamHash() => r'32e2029292a2f1c857cf06c06e9b701e987a5067';

/// See also [wifisStream].
@ProviderFor(wifisStream)
final wifisStreamProvider =
    AutoDisposeStreamProvider<List<WifiNetworkInfo>>.internal(
  wifisStream,
  name: r'wifisStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$wifisStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WifisStreamRef = AutoDisposeStreamProviderRef<List<WifiNetworkInfo>>;
String _$networkNotifierHash() => r'05f4ded280fe137c86a6aa930e8dacbc18396ea8';

/// See also [NetworkNotifier].
@ProviderFor(NetworkNotifier)
final networkNotifierProvider =
    AutoDisposeNotifierProvider<NetworkNotifier, void>.internal(
  NetworkNotifier.new,
  name: r'networkNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NetworkNotifier = AutoDisposeNotifier<void>;
String _$uDPMulticastHash() => r'5a3373e0e38499365a4616c2847a93620aad9ad0';

/// See also [UDPMulticast].
@ProviderFor(UDPMulticast)
final uDPMulticastProvider =
    AutoDisposeStreamNotifierProvider<UDPMulticast, String>.internal(
  UDPMulticast.new,
  name: r'uDPMulticastProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$uDPMulticastHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UDPMulticast = AutoDisposeStreamNotifier<String>;
String _$uDPBroadcastHash() => r'feb13872ed8f0213b91d4c7b4b8ecb3c15924ba9';

/// See also [UDPBroadcast].
@ProviderFor(UDPBroadcast)
final uDPBroadcastProvider =
    AutoDisposeStreamNotifierProvider<UDPBroadcast, String>.internal(
  UDPBroadcast.new,
  name: r'uDPBroadcastProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$uDPBroadcastHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UDPBroadcast = AutoDisposeStreamNotifier<String>;
String _$socketIOClientHash() => r'99df95dfbbcb1a000d4bf770f3d22e8650fc923d';

/// See also [SocketIOClient].
@ProviderFor(SocketIOClient)
final socketIOClientProvider =
    AutoDisposeStreamNotifierProvider<SocketIOClient, String>.internal(
  SocketIOClient.new,
  name: r'socketIOClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$socketIOClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SocketIOClient = AutoDisposeStreamNotifier<String>;
String _$socketIOServerHash() => r'daf84525964ef105f28b07410c527ca6e086f79e';

/// See also [SocketIOServer].
@ProviderFor(SocketIOServer)
final socketIOServerProvider =
    AutoDisposeStreamNotifierProvider<SocketIOServer, String>.internal(
  SocketIOServer.new,
  name: r'socketIOServerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$socketIOServerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SocketIOServer = AutoDisposeStreamNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
