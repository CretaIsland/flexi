// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentInfoImpl _$$ContentInfoImplFromJson(Map<String, dynamic> json) =>
    _$ContentInfoImpl(
      contentId: json['contentId'] as String,
      contentName: json['contentName'] as String? ?? 'New Content',
      width: json['width'] as int? ?? 360,
      height: json['height'] as int? ?? 28,
      x: json['x'] as int? ?? 0,
      y: json['y'] as int? ?? 0,
      isReverse: json['isReverse'] as bool? ?? false,
      text: json['text'] as String? ?? 'Example',
      textSizeType: json['textSizeType'] as String? ?? 's',
      textSize: (json['textSize'] as num?)?.toDouble() ?? 11.2,
      textColor: json['textColor'] as String? ?? 'Color(0xffFFFFFF)',
      bold: json['bold'] as bool? ?? false,
      italic: json['italic'] as bool? ?? false,
      language: json['language'] as String? ?? '',
      backgroundType: json['backgroundType'] as String? ?? 'color',
      backgroundColor:
          json['backgroundColor'] as String? ?? 'Color(0xff000000)',
      filePath: json['filePath'] as String? ?? '',
      fileName: json['fileName'] as String? ?? '',
      fileThumbnail: json['fileThumbnail'] as String? ?? '',
    );

Map<String, dynamic> _$$ContentInfoImplToJson(_$ContentInfoImpl instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'contentName': instance.contentName,
      'width': instance.width,
      'height': instance.height,
      'x': instance.x,
      'y': instance.y,
      'isReverse': instance.isReverse,
      'text': instance.text,
      'textSizeType': instance.textSizeType,
      'textSize': instance.textSize,
      'textColor': instance.textColor,
      'bold': instance.bold,
      'italic': instance.italic,
      'language': instance.language,
      'backgroundType': instance.backgroundType,
      'backgroundColor': instance.backgroundColor,
      'filePath': instance.filePath,
      'fileName': instance.fileName,
      'fileThumbnail': instance.fileThumbnail,
    };
