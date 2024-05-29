// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bluetoothStreamHash() => r'342f569f5a19b586802ecee2eaca11d4ae5498aa';

/// See also [bluetoothStream].
@ProviderFor(bluetoothStream)
final bluetoothStreamProvider =
    AutoDisposeFutureProvider<Stream<List<BluetoothInfo>>>.internal(
  bluetoothStream,
  name: r'bluetoothStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bluetoothStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BluetoothStreamRef
    = AutoDisposeFutureProviderRef<Stream<List<BluetoothInfo>>>;
String _$bondedBluetoothsHash() => r'e079234bfd208a49825a58b7ab6f05a61fcdc03a';

/// See also [bondedBluetooths].
@ProviderFor(bondedBluetooths)
final bondedBluetoothsProvider =
    AutoDisposeFutureProvider<List<BluetoothInfo>>.internal(
  bondedBluetooths,
  name: r'bondedBluetoothsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bondedBluetoothsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BondedBluetoothsRef = AutoDisposeFutureProviderRef<List<BluetoothInfo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
