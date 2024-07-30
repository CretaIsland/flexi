import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_model.freezed.dart';
part 'content_model.g.dart';



@freezed 
class ContentModel with _$ContentModel {
  factory ContentModel({
    required String contentId,
    @Default('') String contentName,
    @Default(360) int width,
    @Default(28) int height,
    @Default(0) int x,
    @Default(0) int y,
    @Default(false) bool isReverse,
    @Default('Hello') String text,
    @Default('S') String textSizeType,
    @Default(11) int textSize,
    @Default('Color(0xffFFFFFF)') String textColor,
    @Default(false) bool bold,
    @Default(false) bool italic,
    @Default('')String language,
    @Default('color') String backgroundType,
    @Default('Color(0xff000000)') String backgroundColor,
    @Default('')String filePath,
    @Default('')String fileName,
    String? fileThumbnail
  }) = _ContentModel;

  ContentModel._();

  factory ContentModel.fromJson(Map<String, dynamic> map) => _$ContentModelFromJson(map);
}