// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WifiNetworkInfo {
  String? get ssid => throw _privateConstructorUsedError;
  String? get bssid => throw _privateConstructorUsedError;
  String? get capabilities => throw _privateConstructorUsedError;
  int? get frequency => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  int? get timestamp => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WifiNetworkInfoCopyWith<WifiNetworkInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WifiNetworkInfoCopyWith<$Res> {
  factory $WifiNetworkInfoCopyWith(
          WifiNetworkInfo value, $Res Function(WifiNetworkInfo) then) =
      _$WifiNetworkInfoCopyWithImpl<$Res, WifiNetworkInfo>;
  @useResult
  $Res call(
      {String? ssid,
      String? bssid,
      String? capabilities,
      int? frequency,
      int? level,
      int? timestamp,
      String? password});
}

/// @nodoc
class _$WifiNetworkInfoCopyWithImpl<$Res, $Val extends WifiNetworkInfo>
    implements $WifiNetworkInfoCopyWith<$Res> {
  _$WifiNetworkInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ssid = freezed,
    Object? bssid = freezed,
    Object? capabilities = freezed,
    Object? frequency = freezed,
    Object? level = freezed,
    Object? timestamp = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      ssid: freezed == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String?,
      bssid: freezed == bssid
          ? _value.bssid
          : bssid // ignore: cast_nullable_to_non_nullable
              as String?,
      capabilities: freezed == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WifiNetworkInfoImplCopyWith<$Res>
    implements $WifiNetworkInfoCopyWith<$Res> {
  factory _$$WifiNetworkInfoImplCopyWith(_$WifiNetworkInfoImpl value,
          $Res Function(_$WifiNetworkInfoImpl) then) =
      __$$WifiNetworkInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? ssid,
      String? bssid,
      String? capabilities,
      int? frequency,
      int? level,
      int? timestamp,
      String? password});
}

/// @nodoc
class __$$WifiNetworkInfoImplCopyWithImpl<$Res>
    extends _$WifiNetworkInfoCopyWithImpl<$Res, _$WifiNetworkInfoImpl>
    implements _$$WifiNetworkInfoImplCopyWith<$Res> {
  __$$WifiNetworkInfoImplCopyWithImpl(
      _$WifiNetworkInfoImpl _value, $Res Function(_$WifiNetworkInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ssid = freezed,
    Object? bssid = freezed,
    Object? capabilities = freezed,
    Object? frequency = freezed,
    Object? level = freezed,
    Object? timestamp = freezed,
    Object? password = freezed,
  }) {
    return _then(_$WifiNetworkInfoImpl(
      ssid: freezed == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String?,
      bssid: freezed == bssid
          ? _value.bssid
          : bssid // ignore: cast_nullable_to_non_nullable
              as String?,
      capabilities: freezed == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WifiNetworkInfoImpl implements _WifiNetworkInfo {
  const _$WifiNetworkInfoImpl(
      {this.ssid,
      this.bssid,
      this.capabilities,
      this.frequency,
      this.level,
      this.timestamp,
      this.password});

  @override
  final String? ssid;
  @override
  final String? bssid;
  @override
  final String? capabilities;
  @override
  final int? frequency;
  @override
  final int? level;
  @override
  final int? timestamp;
  @override
  final String? password;

  @override
  String toString() {
    return 'WifiNetworkInfo(ssid: $ssid, bssid: $bssid, capabilities: $capabilities, frequency: $frequency, level: $level, timestamp: $timestamp, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WifiNetworkInfoImpl &&
            (identical(other.ssid, ssid) || other.ssid == ssid) &&
            (identical(other.bssid, bssid) || other.bssid == bssid) &&
            (identical(other.capabilities, capabilities) ||
                other.capabilities == capabilities) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ssid, bssid, capabilities,
      frequency, level, timestamp, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WifiNetworkInfoImplCopyWith<_$WifiNetworkInfoImpl> get copyWith =>
      __$$WifiNetworkInfoImplCopyWithImpl<_$WifiNetworkInfoImpl>(
          this, _$identity);
}

abstract class _WifiNetworkInfo implements WifiNetworkInfo {
  const factory _WifiNetworkInfo(
      {final String? ssid,
      final String? bssid,
      final String? capabilities,
      final int? frequency,
      final int? level,
      final int? timestamp,
      final String? password}) = _$WifiNetworkInfoImpl;

  @override
  String? get ssid;
  @override
  String? get bssid;
  @override
  String? get capabilities;
  @override
  int? get frequency;
  @override
  int? get level;
  @override
  int? get timestamp;
  @override
  String? get password;
  @override
  @JsonKey(ignore: true)
  _$$WifiNetworkInfoImplCopyWith<_$WifiNetworkInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
