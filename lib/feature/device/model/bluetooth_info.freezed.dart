// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluetooth_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BluetoothInfo {
  String? get name => throw _privateConstructorUsedError;
  String? get remoteId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BluetoothInfoCopyWith<BluetoothInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothInfoCopyWith<$Res> {
  factory $BluetoothInfoCopyWith(
          BluetoothInfo value, $Res Function(BluetoothInfo) then) =
      _$BluetoothInfoCopyWithImpl<$Res, BluetoothInfo>;
  @useResult
  $Res call({String? name, String? remoteId});
}

/// @nodoc
class _$BluetoothInfoCopyWithImpl<$Res, $Val extends BluetoothInfo>
    implements $BluetoothInfoCopyWith<$Res> {
  _$BluetoothInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? remoteId = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      remoteId: freezed == remoteId
          ? _value.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BluetoothInfoImplCopyWith<$Res>
    implements $BluetoothInfoCopyWith<$Res> {
  factory _$$BluetoothInfoImplCopyWith(
          _$BluetoothInfoImpl value, $Res Function(_$BluetoothInfoImpl) then) =
      __$$BluetoothInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? remoteId});
}

/// @nodoc
class __$$BluetoothInfoImplCopyWithImpl<$Res>
    extends _$BluetoothInfoCopyWithImpl<$Res, _$BluetoothInfoImpl>
    implements _$$BluetoothInfoImplCopyWith<$Res> {
  __$$BluetoothInfoImplCopyWithImpl(
      _$BluetoothInfoImpl _value, $Res Function(_$BluetoothInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? remoteId = freezed,
  }) {
    return _then(_$BluetoothInfoImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      remoteId: freezed == remoteId
          ? _value.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BluetoothInfoImpl implements _BluetoothInfo {
  const _$BluetoothInfoImpl({this.name, this.remoteId});

  @override
  final String? name;
  @override
  final String? remoteId;

  @override
  String toString() {
    return 'BluetoothInfo(name: $name, remoteId: $remoteId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BluetoothInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.remoteId, remoteId) ||
                other.remoteId == remoteId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, remoteId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BluetoothInfoImplCopyWith<_$BluetoothInfoImpl> get copyWith =>
      __$$BluetoothInfoImplCopyWithImpl<_$BluetoothInfoImpl>(this, _$identity);
}

abstract class _BluetoothInfo implements BluetoothInfo {
  const factory _BluetoothInfo({final String? name, final String? remoteId}) =
      _$BluetoothInfoImpl;

  @override
  String? get name;
  @override
  String? get remoteId;
  @override
  @JsonKey(ignore: true)
  _$$BluetoothInfoImplCopyWith<_$BluetoothInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
