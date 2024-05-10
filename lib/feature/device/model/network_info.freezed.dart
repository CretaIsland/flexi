// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NetworkInfo {
  String? get ssid => throw _privateConstructorUsedError;
  String? get bssid => throw _privateConstructorUsedError;
  String? get ip => throw _privateConstructorUsedError;
  String? get ipv6 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NetworkInfoCopyWith<NetworkInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkInfoCopyWith<$Res> {
  factory $NetworkInfoCopyWith(
          NetworkInfo value, $Res Function(NetworkInfo) then) =
      _$NetworkInfoCopyWithImpl<$Res, NetworkInfo>;
  @useResult
  $Res call({String? ssid, String? bssid, String? ip, String? ipv6});
}

/// @nodoc
class _$NetworkInfoCopyWithImpl<$Res, $Val extends NetworkInfo>
    implements $NetworkInfoCopyWith<$Res> {
  _$NetworkInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ssid = freezed,
    Object? bssid = freezed,
    Object? ip = freezed,
    Object? ipv6 = freezed,
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
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      ipv6: freezed == ipv6
          ? _value.ipv6
          : ipv6 // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkInfoImplCopyWith<$Res>
    implements $NetworkInfoCopyWith<$Res> {
  factory _$$NetworkInfoImplCopyWith(
          _$NetworkInfoImpl value, $Res Function(_$NetworkInfoImpl) then) =
      __$$NetworkInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? ssid, String? bssid, String? ip, String? ipv6});
}

/// @nodoc
class __$$NetworkInfoImplCopyWithImpl<$Res>
    extends _$NetworkInfoCopyWithImpl<$Res, _$NetworkInfoImpl>
    implements _$$NetworkInfoImplCopyWith<$Res> {
  __$$NetworkInfoImplCopyWithImpl(
      _$NetworkInfoImpl _value, $Res Function(_$NetworkInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ssid = freezed,
    Object? bssid = freezed,
    Object? ip = freezed,
    Object? ipv6 = freezed,
  }) {
    return _then(_$NetworkInfoImpl(
      ssid: freezed == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String?,
      bssid: freezed == bssid
          ? _value.bssid
          : bssid // ignore: cast_nullable_to_non_nullable
              as String?,
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      ipv6: freezed == ipv6
          ? _value.ipv6
          : ipv6 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NetworkInfoImpl implements _NetworkInfo {
  const _$NetworkInfoImpl({this.ssid, this.bssid, this.ip, this.ipv6});

  @override
  final String? ssid;
  @override
  final String? bssid;
  @override
  final String? ip;
  @override
  final String? ipv6;

  @override
  String toString() {
    return 'NetworkInfo(ssid: $ssid, bssid: $bssid, ip: $ip, ipv6: $ipv6)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkInfoImpl &&
            (identical(other.ssid, ssid) || other.ssid == ssid) &&
            (identical(other.bssid, bssid) || other.bssid == bssid) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.ipv6, ipv6) || other.ipv6 == ipv6));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ssid, bssid, ip, ipv6);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkInfoImplCopyWith<_$NetworkInfoImpl> get copyWith =>
      __$$NetworkInfoImplCopyWithImpl<_$NetworkInfoImpl>(this, _$identity);
}

abstract class _NetworkInfo implements NetworkInfo {
  const factory _NetworkInfo(
      {final String? ssid,
      final String? bssid,
      final String? ip,
      final String? ipv6}) = _$NetworkInfoImpl;

  @override
  String? get ssid;
  @override
  String? get bssid;
  @override
  String? get ip;
  @override
  String? get ipv6;
  @override
  @JsonKey(ignore: true)
  _$$NetworkInfoImplCopyWith<_$NetworkInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
