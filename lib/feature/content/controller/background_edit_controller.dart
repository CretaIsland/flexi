import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/content_info.dart';
import 'content_info_controller.dart';

part 'background_edit_controller.g.dart';



final tabIndexProvider = StateProvider<int>((ref) => 0);


@riverpod
class BackgroundEditController extends _$BackgroundEditController {

  @override
  ContentInfo? build() {
    ref.onDispose(() {
      print("<<<<<<< BackgroundEditController dispose <<<<<<<");
    });
    print("<<<<<<< BackgroundEditController build <<<<<<<");
    return ref.read(contentInfoControllerProvider);
  }


  // background 색깔로 변경하기
  void setBackgroundColor(Color color) {
    state = state!.copyWith(
      backgroundType: 'color', 
      backgroundColor: color.toString(),
      contentBytes: '',
      contentFileName: '',
      contentThumbnail: ''
    );
  }

  // background 콘텐츠로 변경하기
  void setBackgroundContent(String contentType, Uint8List contentBytes, String contentName, Uint8List contentThumbnail) {
    state = state!.copyWith(
      backgroundType: contentType, 
      contentBytes: base64Encode(contentBytes),
      contentFileName: contentName,
      contentThumbnail: base64Encode(contentThumbnail)
    );
  }

}