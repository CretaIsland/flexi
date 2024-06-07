import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/content_info.dart';
import 'content_info_controller.dart';

part 'content_send_controller.g.dart';



final selectDeviceProvider = StateProvider<int>((ref) => -1);


@riverpod
class ContentSendController extends _$ContentSendController {

  @override
  ContentInfo? build() {
    ref.onDispose(() {
      print("<<<<<<< ContentSendController dispose <<<<<<<");
    });
    print("<<<<<<< ContentSendController build <<<<<<<");
    return ref.read(contentInfoControllerProvider)!;
  }

  Future<void> getContentBytes() async {
    // if(state!.filePath.startsWith('asset:')) {

    // } else {

    // }
  }

}