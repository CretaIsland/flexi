// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bondedBluetoothsHash() => r'a4b92fad9903ec3c54f45253fb75c6bf7fc8a7cb';

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
String _$accessibleBluetoothsHash() =>
    r'a49e5906832a2fb1e50b3e1ce6cab6952cdefbf4';

/// See also [accessibleBluetooths].
@ProviderFor(accessibleBluetooths)
final accessibleBluetoothsProvider =
    AutoDisposeFutureProvider<Stream<List<BluetoothInfo>>>.internal(
  accessibleBluetooths,
  name: r'accessibleBluetoothsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accessibleBluetoothsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccessibleBluetoothsRef
    = AutoDisposeFutureProviderRef<Stream<List<BluetoothInfo>>>;
String _$deviceInfoControllerHash() =>
    r'9963d3f41865865f0c8704cf9b1843fb460b6f17';

/// See also [DeviceInfoController].
@ProviderFor(DeviceInfoController)
final deviceInfoControllerProvider =
    AutoDisposeNotifierProvider<DeviceInfoController, DeviceInfo>.internal(
  DeviceInfoController.new,
  name: r'deviceInfoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deviceInfoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeviceInfoController = AutoDisposeNotifier<DeviceInfo>;
String _$bluetoothStateControllerHash() =>
    r'4937356524517361821fec0e7434a508809fef5f';

/// See also [BluetoothStateController].
@ProviderFor(BluetoothStateController)
final bluetoothStateControllerProvider =
    AutoDisposeNotifierProvider<BluetoothStateController, bool>.internal(
  BluetoothStateController.new,
  name: r'bluetoothStateControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bluetoothStateControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BluetoothStateController = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
