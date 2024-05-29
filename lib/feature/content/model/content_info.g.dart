// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentInfoImpl _$$ContentInfoImplFromJson(Map<String, dynamic> json) =>
    _$ContentInfoImpl(
      contentId: json['contentId'] as String,
      contentName: json['contentName'] as String,
      width: json['width'] as int? ?? 360,
      height: json['height'] as int? ?? 28,
      x: json['x'] as int? ?? 0,
      y: json['y'] as int? ?? 0,
      isReverse: json['isReverse'] as bool? ?? false,
      text: json['text'] as String? ?? '',
      textSize: json['textSize'] as String? ?? 'small',
      textColor: json['textColor'] as String? ?? '#000000',
      isBold: json['isBold'] as bool? ?? false,
      isItalic: json['isItalic'] as bool? ?? false,
      language: json['language'] as String?,
      backgroundType: json['backgroundType'] as String? ?? 'color',
      backgroundColor: json['backgroundColor'] as String? ?? '#FFFFFF',
      backgroundContent: json['backgroundContent'] as String?,
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
      'textSize': instance.textSize,
      'textColor': instance.textColor,
      'isBold': instance.isBold,
      'isItalic': instance.isItalic,
      'language': instance.language,
      'backgroundType': instance.backgroundType,
      'backgroundColor': instance.backgroundColor,
      'backgroundContent': instance.backgroundContent,
    };
