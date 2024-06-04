import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_info.freezed.dart';
part 'content_info.g.dart';



@freezed
class ContentInfo with _$ContentInfo {
  factory ContentInfo({
    required String id,
    @Default('New Content')String name,
    @Default(360) int width,
    @Default(28) int height,
    @Default(0) int x,
    @Default(0) int y,
    @Default(false) bool isReverse,
    @Default('Example') String text,
    @Default('s')String textSizeType,
    @Default(11.2)double textSize,
    @Default('Color(0xffFFFFFF)') String textColor,
    @Default(false) bool isBold,
    @Default(false) bool isItalic,
    @Default('')String languageType,
    @Default('color') String backgroundType,
    @Default('Color(0xff000000)') String backgroundColor,
    @Default('')String contentPath,
    @Default('')String contentFileName,
    @Default('')String contentThumbnail
  }) = _ContentInfo;

  ContentInfo._();

  factory ContentInfo.fromJson(Map<String, dynamic> map) => _$ContentInfoFromJson(map);

}