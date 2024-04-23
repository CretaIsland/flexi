// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$internetConnectionHash() =>
    r'7836c85109e37c4b96bde8fad2eafce0fe42cf42';

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
String _$networkChangeHash() => r'599486ec328162268c4141f92cbf66494482fd84';

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
String _$ipHash() => r'fb249f1bf4dece0dbf110eb4e216740f59d07d15';

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
String _$networkInfoHash() => r'e0911d88dd11068fba00643f61821f9f139ec0dd';

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
String _$wifisHash() => r'61b23a177d2027c425a51d1f3d2213a79f0b7077';

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
String _$wifisStreamHash() => r'fdb38b45b142787e7244ba1ad1f6f8bf9b3bb36f';

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
String _$networkNotifierHash() => r'901b9dd04f8e62a27b40d034c54eadac6c8db36a';

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
String _$uDPMulticastHash() => r'1d46f2e185b329ea7fe1fe7e9b5d8cf416fac8d3';

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
String _$uDPMulticastNotifierHash() =>
    r'be2b9fa45db4d305b5b780ebdc868e81d823d09c';

/// See also [UDPMulticastNotifier].
@ProviderFor(UDPMulticastNotifier)
final uDPMulticastNotifierProvider =
    AutoDisposeAsyncNotifierProvider<UDPMulticastNotifier, void>.internal(
  UDPMulticastNotifier.new,
  name: r'uDPMulticastNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$uDPMulticastNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UDPMulticastNotifier = AutoDisposeAsyncNotifier<void>;
String _$socketIOClientHash() => r'b678e97f9f4296c78148573d025a0d34f3e7a140';

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
String _$socketIOClientNotifierHash() =>
    r'faeffd7bd24bcd3bba46eaa6b6dcc43551127f53';

/// See also [SocketIOClientNotifier].
@ProviderFor(SocketIOClientNotifier)
final socketIOClientNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SocketIOClientNotifier, void>.internal(
  SocketIOClientNotifier.new,
  name: r'socketIOClientNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$socketIOClientNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SocketIOClientNotifier = AutoDisposeAsyncNotifier<void>;
String _$socketIOServerHash() => r'1f76f2b121df20a386846416c3aa660d98bc156f';

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
String _$socketIOServerNotifierHash() =>
    r'f5e790a3bcf6d5a6ca464f1f2fb00e2481f378e4';

/// See also [SocketIOServerNotifier].
@ProviderFor(SocketIOServerNotifier)
final socketIOServerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SocketIOServerNotifier, void>.internal(
  SocketIOServerNotifier.new,
  name: r'socketIOServerNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$socketIOServerNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SocketIOServerNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
