// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_providers.dart';

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
String _$uDPBroadcastHash() => r'cbe16618d5c0d39e837323caaabc284cc8e1a7e8';

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
String _$socketIOClientHash() => r'432c5c9c02649899ba1fc7274677c91c0a600af6';

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

abstract class _$SocketIOClient
    extends BuildlessAutoDisposeStreamNotifier<String> {
  late final String ip;
  late final int port;

  Stream<String> build({
    required String ip,
    required int port,
  });
}

/// See also [SocketIOClient].
@ProviderFor(SocketIOClient)
const socketIOClientProvider = SocketIOClientFamily();

/// See also [SocketIOClient].
class SocketIOClientFamily extends Family<AsyncValue<String>> {
  /// See also [SocketIOClient].
  const SocketIOClientFamily();

  /// See also [SocketIOClient].
  SocketIOClientProvider call({
    required String ip,
    required int port,
  }) {
    return SocketIOClientProvider(
      ip: ip,
      port: port,
    );
  }

  @override
  SocketIOClientProvider getProviderOverride(
    covariant SocketIOClientProvider provider,
  ) {
    return call(
      ip: provider.ip,
      port: provider.port,
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
  String? get name => r'socketIOClientProvider';
}

/// See also [SocketIOClient].
class SocketIOClientProvider
    extends AutoDisposeStreamNotifierProviderImpl<SocketIOClient, String> {
  /// See also [SocketIOClient].
  SocketIOClientProvider({
    required String ip,
    required int port,
  }) : this._internal(
          () => SocketIOClient()
            ..ip = ip
            ..port = port,
          from: socketIOClientProvider,
          name: r'socketIOClientProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$socketIOClientHash,
          dependencies: SocketIOClientFamily._dependencies,
          allTransitiveDependencies:
              SocketIOClientFamily._allTransitiveDependencies,
          ip: ip,
          port: port,
        );

  SocketIOClientProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ip,
    required this.port,
  }) : super.internal();

  final String ip;
  final int port;

  @override
  Stream<String> runNotifierBuild(
    covariant SocketIOClient notifier,
  ) {
    return notifier.build(
      ip: ip,
      port: port,
    );
  }

  @override
  Override overrideWith(SocketIOClient Function() create) {
    return ProviderOverride(
      origin: this,
      override: SocketIOClientProvider._internal(
        () => create()
          ..ip = ip
          ..port = port,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ip: ip,
        port: port,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<SocketIOClient, String>
      createElement() {
    return _SocketIOClientProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SocketIOClientProvider &&
        other.ip == ip &&
        other.port == port;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ip.hashCode);
    hash = _SystemHash.combine(hash, port.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SocketIOClientRef on AutoDisposeStreamNotifierProviderRef<String> {
  /// The parameter `ip` of this provider.
  String get ip;

  /// The parameter `port` of this provider.
  int get port;
}

class _SocketIOClientProviderElement
    extends AutoDisposeStreamNotifierProviderElement<SocketIOClient, String>
    with SocketIOClientRef {
  _SocketIOClientProviderElement(super.provider);

  @override
  String get ip => (origin as SocketIOClientProvider).ip;
  @override
  int get port => (origin as SocketIOClientProvider).port;
}

String _$socketIOServerHash() => r'cb269457d9955d9e35dbdfbb5e89d16f4db7ec55';

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
