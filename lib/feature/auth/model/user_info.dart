import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';



@freezed
class UserInfo with _$UserInfo {
  factory UserInfo({
    required String email,
    @Default('') String nickname,
  }) = _UserInfo;

  UserInfo._();

  factory UserInfo.fromJson(Map<String, dynamic> map) => _$UserInfoFromJson(map);

}