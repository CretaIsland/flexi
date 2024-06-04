import 'dart:io';

import 'package:flexi/feature/content/controller/content_info_controller.dart';
import 'package:flexi/feature/content/model/content_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_send_controller.g.dart';



final selectDeviceProvider = StateProvider<int>((ref) => -1);


@riverpod
class ContentSendController extends _$ContentSendController {

  late ContentInfo contentInfo;

  @override
  void build() {
    contentInfo = ref.read(contentInfoControllerProvider)!;
  }

  Future<void> getContentBytes() async {
    if(contentInfo.contentPath.startsWith('asset:')) {

    } else {

    }
  }

}