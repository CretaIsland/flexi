import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_info.freezed.dart';
part 'content_info.g.dart';



@freezed
class ContentInfo with _$ContentInfo {
  factory ContentInfo({
    required String contentId,
    @Default('New Content')String contentName,
    @Default(360) int width,
    @Default(28) int height,
    @Default(0) int x,
    @Default(0) int y,
    @Default(false) bool isReverse,
    @Default('Example') String text,
    @Default('s')String textSizeType,
    @Default(11.2)double textSize,
    @Default('Color(0xffFFFFFF)') String textColor,
    @Default(false) bool bold,
    @Default(false) bool italic,
    @Default('')String language,
    @Default('color') String backgroundType,
    @Default('Color(0xff000000)') String backgroundColor,
    @Default('')String filePath,
    @Default('')String fileName,
    @Default('')String fileThumbnail
  }) = _ContentInfo;

  ContentInfo._();

  factory ContentInfo.fromJson(Map<String, dynamic> map) => _$ContentInfoFromJson(map);

}