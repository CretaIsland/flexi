import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';



@freezed 
class UserModel with _$UserModel {

  factory UserModel({
    required String email,
    @Default('') String nickname,
    @Default('') String enterprise
  }) = _UserModel;

  UserModel._();
  factory UserModel.fromJson(Map<String, dynamic> map) => _$UserModelFromJson(map);

}