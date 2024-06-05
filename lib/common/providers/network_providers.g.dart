// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ipHash() => r'591fbef63c7da58cacec12d9d069b13802f3726d';

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
String _$networkInfoHash() => r'50c48a81fe72a1c5e175b93b3134dbe545e122f2';

/// See also [networkInfo].
@ProviderFor(networkInfo)
final networkInfoProvider = AutoDisposeFutureProvider<NetworkInfo?>.internal(
  networkInfo,
  name: r'networkInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$networkInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NetworkInfoRef = AutoDisposeFutureProviderRef<NetworkInfo?>;
String _$uDPBroadcastHash() => r'e35f67225d182407221fcfe75789a28d62cdf06a';

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
String _$socketIOClientHash() => r'6f302a793cd0432bf31f3308730ea623e3a38b58';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
