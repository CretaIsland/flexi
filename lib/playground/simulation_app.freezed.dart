// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_app.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Command _$CommandFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'playerStatus':
      return _PlayerStatus.fromJson(json);
    case 'register':
      return _Register.fromJson(json);
    case 'unRegister':
      return _UnRegister.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Command',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Command {
  String get command => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String command,
            String deviceId,
            String? connectionMode,
            String? ip,
            bool? isRegistered,
            bool? hasContent)
        playerStatus,
    required TResult Function(
            String command, String deviceId, String? ssid, String? password)
        register,
    required TResult Function(String command, String deviceId) unRegister,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String command, String deviceId, String? connectionMode,
            String? ip, bool? isRegistered, bool? hasContent)?
        playerStatus,
    TResult? Function(
            String command, String deviceId, String? ssid, String? password)?
        register,
    TResult? Function(String command, String deviceId)? unRegister,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String command, String deviceId, String? connectionMode,
            String? ip, bool? isRegistered, bool? hasContent)?
        playerStatus,
    TResult Function(
            String command, String deviceId, String? ssid, String? password)?
        register,
    TResult Function(String command, String deviceId)? unRegister,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PlayerStatus value) playerStatus,
    required TResult Function(_Register value) register,
    required TResult Function(_UnRegister value) unRegister,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PlayerStatus value)? playerStatus,
    TResult? Function(_Register value)? register,
    TResult? Function(_UnRegister value)? unRegister,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlayerStatus value)? playerStatus,
    TResult Function(_Register value)? register,
    TResult Function(_UnRegister value)? unRegister,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommandCopyWith<Command> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommandCopyWith<$Res> {
  factory $CommandCopyWith(Command value, $Res Function(Command) then) =
      _$CommandCopyWithImpl<$Res, Command>;
  @useResult
  $Res call({String command, String deviceId});
}

/// @nodoc
class _$CommandCopyWithImpl<$Res, $Val extends Command>
    implements $CommandCopyWith<$Res> {
  _$CommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? deviceId = null,
  }) {
    return _then(_value.copyWith(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerStatusImplCopyWith<$Res>
    implements $CommandCopyWith<$Res> {
  factory _$$PlayerStatusImplCopyWith(
          _$PlayerStatusImpl value, $Res Function(_$PlayerStatusImpl) then) =
      __$$PlayerStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String command,
      String deviceId,
      String? connectionMode,
      String? ip,
      bool? isRegistered,
      bool? hasContent});
}

/// @nodoc
class __$$PlayerStatusImplCopyWithImpl<$Res>
    extends _$CommandCopyWithImpl<$Res, _$PlayerStatusImpl>
    implements _$$PlayerStatusImplCopyWith<$Res> {
  __$$PlayerStatusImplCopyWithImpl(
      _$PlayerStatusImpl _value, $Res Function(_$PlayerStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? deviceId = null,
    Object? connectionMode = freezed,
    Object? ip = freezed,
    Object? isRegistered = freezed,
    Object? hasContent = freezed,
  }) {
    return _then(_$PlayerStatusImpl(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      connectionMode: freezed == connectionMode
          ? _value.connectionMode
          : connectionMode // ignore: cast_nullable_to_non_nullable
              as String?,
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      isRegistered: freezed == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasContent: freezed == hasContent
          ? _value.hasContent
          : hasContent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerStatusImpl implements _PlayerStatus {
  const _$PlayerStatusImpl(
      {required this.command,
      required this.deviceId,
      this.connectionMode,
      this.ip,
      this.isRegistered,
      this.hasContent,
      final String? $type})
      : $type = $type ?? 'playerStatus';

  factory _$PlayerStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStatusImplFromJson(json);

  @override
  final String command;
  @override
  final String deviceId;
  @override
  final String? connectionMode;
  @override
  final String? ip;
  @override
  final bool? isRegistered;
  @override
  final bool? hasContent;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Command.playerStatus(command: $command, deviceId: $deviceId, connectionMode: $connectionMode, ip: $ip, isRegistered: $isRegistered, hasContent: $hasContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatusImpl &&
            (identical(other.command, command) || other.command == command) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.connectionMode, connectionMode) ||
                other.connectionMode == connectionMode) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.isRegistered, isRegistered) ||
                other.isRegistered == isRegistered) &&
            (identical(other.hasContent, hasContent) ||
                other.hasContent == hasContent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, command, deviceId,
      connectionMode, ip, isRegistered, hasContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatusImplCopyWith<_$PlayerStatusImpl> get copyWith =>
      __$$PlayerStatusImplCopyWithImpl<_$PlayerStatusImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String command,
            String deviceId,
            String? connectionMode,
            String? ip,
            bool? isRegistered,
            bool? hasContent)
        playerStatus,
    required TResult Function(
            String command, String deviceId, String? ssid, String? password)
        register,
    required TResult Function(String command, String deviceId) unRegister,
  }) {
    return playerStatus(
        command, deviceId, connectionMode, ip, isRegistered, hasContent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String command, String deviceId, String? connectionMode,
            String? ip, bool? isRegistered, bool? hasContent)?
        playerStatus,
    TResult? Function(
            String command, String deviceId, String? ssid, String? password)?
        register,
    TResult? Function(String command, String deviceId)? unRegister,
  }) {
    return playerStatus?.call(
        command, deviceId, connectionMode, ip, isRegistered, hasContent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String command, String deviceId, String? connectionMode,
            String? ip, bool? isRegistered, bool? hasContent)?
        playerStatus,
    TResult Function(
            String command, String deviceId, String? ssid, String? password)?
        register,
    TResult Function(String command, String deviceId)? unRegister,
    required TResult orElse(),
  }) {
    if (playerStatus != null) {
      return playerStatus(
          command, deviceId, connectionMode, ip, isRegistered, hasContent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PlayerStatus value) playerStatus,
    required TResult Function(_Register value) register,
    required TResult Function(_UnRegister value) unRegister,
  }) {
    return playerStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PlayerStatus value)? playerStatus,
    TResult? Function(_Register value)? register,
    TResult? Function(_UnRegister value)? unRegister,
  }) {
    return playerStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlayerStatus value)? playerStatus,
    TResult Function(_Register value)? register,
    TResult Function(_UnRegister value)? unRegister,
    required TResult orElse(),
  }) {
    if (playerStatus != null) {
      return playerStatus(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStatusImplToJson(
      this,
    );
  }
}

abstract class _PlayerStatus implements Command {
  const factory _PlayerStatus(
      {required final String command,
      required final String deviceId,
      final String? connectionMode,
      final String? ip,
      final bool? isRegistered,
      final bool? hasContent}) = _$PlayerStatusImpl;

  factory _PlayerStatus.fromJson(Map<String, dynamic> json) =
      _$PlayerStatusImpl.fromJson;

  @override
  String get command;
  @override
  String get deviceId;
  String? get connectionMode;
  String? get ip;
  bool? get isRegistered;
  bool? get hasContent;
  @override
  @JsonKey(ignore: true)
  _$$PlayerStatusImplCopyWith<_$PlayerStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterImplCopyWith<$Res> implements $CommandCopyWith<$Res> {
  factory _$$RegisterImplCopyWith(
          _$RegisterImpl value, $Res Function(_$RegisterImpl) then) =
      __$$RegisterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String command, String deviceId, String? ssid, String? password});
}

/// @nodoc
class __$$RegisterImplCopyWithImpl<$Res>
    extends _$CommandCopyWithImpl<$Res, _$RegisterImpl>
    implements _$$RegisterImplCopyWith<$Res> {
  __$$RegisterImplCopyWithImpl(
      _$RegisterImpl _value, $Res Function(_$RegisterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? deviceId = null,
    Object? ssid = freezed,
    Object? password = freezed,
  }) {
    return _then(_$RegisterImpl(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      ssid: freezed == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterImpl implements _Register {
  const _$RegisterImpl(
      {required this.command,
      required this.deviceId,
      this.ssid,
      this.password,
      final String? $type})
      : $type = $type ?? 'register';

  factory _$RegisterImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterImplFromJson(json);

  @override
  final String command;
  @override
  final String deviceId;
  @override
  final String? ssid;
  @override
  final String? password;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Command.register(command: $command, deviceId: $deviceId, ssid: $ssid, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterImpl &&
            (identical(other.command, command) || other.command == command) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.ssid, ssid) || other.ssid == ssid) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, command, deviceId, ssid, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterImplCopyWith<_$RegisterImpl> get copyWith =>
      __$$RegisterImplCopyWithImpl<_$RegisterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String command,
            String deviceId,
            String? connectionMode,
            String? ip,
            bool? isRegistered,
            bool? hasContent)
        playerStatus,
    required TResult Function(
            String command, String deviceId, String? ssid, String? password)
        register,
    required TResult Function(String command, String deviceId) unRegister,
  }) {
    return register(command, deviceId, ssid, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String command, String deviceId, String? connectionMode,
            String? ip, bool? isRegistered, bool? hasContent)?
        playerStatus,
    TResult? Function(
            String command, String deviceId, String? ssid, String? password)?
        register,
    TResult? Function(String command, String deviceId)? unRegister,
  }) {
    return register?.call(command, deviceId, ssid, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String command, String deviceId, String? connectionMode,
            String? ip, bool? isRegistered, bool? hasContent)?
        playerStatus,
    TResult Function(
            String command, String deviceId, String? ssid, String? password)?
        register,
    TResult Function(String command, String deviceId)? unRegister,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(command, deviceId, ssid, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PlayerStatus value) playerStatus,
    required TResult Function(_Register value) register,
    required TResult Function(_UnRegister value) unRegister,
  }) {
    return register(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PlayerStatus value)? playerStatus,
    TResult? Function(_Register value)? register,
    TResult? Function(_UnRegister value)? unRegister,
  }) {
    return register?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlayerStatus value)? playerStatus,
    TResult Function(_Register value)? register,
    TResult Function(_UnRegister value)? unRegister,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterImplToJson(
      this,
    );
  }
}

abstract class _Register implements Command {
  const factory _Register(
      {required final String command,
      required final String deviceId,
      final String? ssid,
      final String? password}) = _$RegisterImpl;

  factory _Register.fromJson(Map<String, dynamic> json) =
      _$RegisterImpl.fromJson;

  @override
  String get command;
  @override
  String get deviceId;
  String? get ssid;
  String? get password;
  @override
  @JsonKey(ignore: true)
  _$$RegisterImplCopyWith<_$RegisterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnRegisterImplCopyWith<$Res>
    implements $CommandCopyWith<$Res> {
  factory _$$UnRegisterImplCopyWith(
          _$UnRegisterImpl value, $Res Function(_$UnRegisterImpl) then) =
      __$$UnRegisterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String command, String deviceId});
}

/// @nodoc
class __$$UnRegisterImplCopyWithImpl<$Res>
    extends _$CommandCopyWithImpl<$Res, _$UnRegisterImpl>
    implements _$$UnRegisterImplCopyWith<$Res> {
  __$$UnRegisterImplCopyWithImpl(
      _$UnRegisterImpl _value, $Res Function(_$UnRegisterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? deviceId = null,
  }) {
    return _then(_$UnRegisterImpl(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnRegisterImpl implements _UnRegister {
  const _$UnRegisterImpl(
      {required this.command, required this.deviceId, final String? $type})
      : $type = $type ?? 'unRegister';

  factory _$UnRegisterImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnRegisterImplFromJson(json);

  @override
  final String command;
  @override
  final String deviceId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Command.unRegister(command: $command, deviceId: $deviceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnRegisterImpl &&
            (identical(other.command, command) || other.command == command) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, command, deviceId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnRegisterImplCopyWith<_$UnRegisterImpl> get copyWith =>
      __$$UnRegisterImplCopyWithImpl<_$UnRegisterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String command,
            String deviceId,
            String? connectionMode,
            String? ip,
            bool? isRegistered,
            bool? hasContent)
        playerStatus,
    required TResult Function(
            String command, String deviceId, String? ssid, String? password)
        register,
    required TResult Function(String command, String deviceId) unRegister,
  }) {
    return unRegister(command, deviceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String command, String deviceId, String? connectionMode,
            String? ip, bool? isRegistered, bool? hasContent)?
        playerStatus,
    TResult? Function(
            String command, String deviceId, String? ssid, String? password)?
        register,
    TResult? Function(String command, String deviceId)? unRegister,
  }) {
    return unRegister?.call(command, deviceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String command, String deviceId, String? connectionMode,
            String? ip, bool? isRegistered, bool? hasContent)?
        playerStatus,
    TResult Function(
            String command, String deviceId, String? ssid, String? password)?
        register,
    TResult Function(String command, String deviceId)? unRegister,
    required TResult orElse(),
  }) {
    if (unRegister != null) {
      return unRegister(command, deviceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PlayerStatus value) playerStatus,
    required TResult Function(_Register value) register,
    required TResult Function(_UnRegister value) unRegister,
  }) {
    return unRegister(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PlayerStatus value)? playerStatus,
    TResult? Function(_Register value)? register,
    TResult? Function(_UnRegister value)? unRegister,
  }) {
    return unRegister?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlayerStatus value)? playerStatus,
    TResult Function(_Register value)? register,
    TResult Function(_UnRegister value)? unRegister,
    required TResult orElse(),
  }) {
    if (unRegister != null) {
      return unRegister(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnRegisterImplToJson(
      this,
    );
  }
}

abstract class _UnRegister implements Command {
  const factory _UnRegister(
      {required final String command,
      required final String deviceId}) = _$UnRegisterImpl;

  factory _UnRegister.fromJson(Map<String, dynamic> json) =
      _$UnRegisterImpl.fromJson;

  @override
  String get command;
  @override
  String get deviceId;
  @override
  @JsonKey(ignore: true)
  _$$UnRegisterImplCopyWith<_$UnRegisterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
