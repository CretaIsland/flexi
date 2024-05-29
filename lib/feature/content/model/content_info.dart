import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_info.freezed.dart';
part 'content_info.g.dart';



@freezed
class ContentInfo with _$ContentInfo {

  const factory ContentInfo({
    required String contentId,
    required String contentName,
    @Default(360) int width,
    @Default(28) int height,
    @Default(0) int x,
    @Default(0) int y,
    @Default(false) bool isReverse,
    @Default('')String text,
    @Default('small')String textSize,
    @Default('#000000')String textColor,
    @Default(false) bool isBold,
    @Default(false) bool isItalic,
    String? language,
    @Default('color') String backgroundType,
    @Default('#FFFFFF') String backgroundColor,
    String? backgroundContent
  }) = _ContentInfo;

  factory ContentInfo.fromJson(Map<String, dynamic> json) => _$ContentInfoFromJson(json);

}