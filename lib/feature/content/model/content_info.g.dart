// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentInfoImpl _$$ContentInfoImplFromJson(Map<String, dynamic> json) =>
    _$ContentInfoImpl(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'New Content',
      width: json['width'] as int? ?? 360,
      height: json['height'] as int? ?? 28,
      x: json['x'] as int? ?? 0,
      y: json['y'] as int? ?? 0,
      isReverse: json['isReverse'] as bool? ?? false,
      text: json['text'] as String? ?? 'Example',
      textSizeType: json['textSizeType'] as String? ?? 's',
      textSize: (json['textSize'] as num?)?.toDouble() ?? 11.2,
      textColor: json['textColor'] as String? ?? 'Color(0xffFFFFFF)',
      isBold: json['isBold'] as bool? ?? false,
      isItalic: json['isItalic'] as bool? ?? false,
      languageType: json['languageType'] as String? ?? '',
      backgroundType: json['backgroundType'] as String? ?? 'color',
      backgroundColor:
          json['backgroundColor'] as String? ?? 'Color(0xff000000)',
      contentBytes: json['contentBytes'] as String? ?? '',
      contentFileName: json['contentFileName'] as String? ?? '',
      contentThumbnail: json['contentThumbnail'] as String? ?? '',
    );

Map<String, dynamic> _$$ContentInfoImplToJson(_$ContentInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'x': instance.x,
      'y': instance.y,
      'isReverse': instance.isReverse,
      'text': instance.text,
      'textSizeType': instance.textSizeType,
      'textSize': instance.textSize,
      'textColor': instance.textColor,
      'isBold': instance.isBold,
      'isItalic': instance.isItalic,
      'languageType': instance.languageType,
      'backgroundType': instance.backgroundType,
      'backgroundColor': instance.backgroundColor,
      'contentBytes': instance.contentBytes,
      'contentFileName': instance.contentFileName,
      'contentThumbnail': instance.contentThumbnail,
    };
