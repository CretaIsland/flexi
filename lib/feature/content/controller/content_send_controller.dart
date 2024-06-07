import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../device/model/device_info.dart';
import '../model/content_info.dart';
import 'content_info_controller.dart';

part 'content_send_controller.g.dart';



final selectDeviceProvider = StateProvider<DeviceInfo?>((ref) => null);


@riverpod
class ContentSendController extends _$ContentSendController {

  @override
  ContentInfo build() {
    ref.onDispose(() {
      print("<<<<<<< ContentSendController dispose <<<<<<<");
    });
    print("<<<<<<< ContentSendController build <<<<<<<");
    return ref.read(contentInfoControllerProvider)!;
  }

  Future<File?> getContentFile() async {
    try {
      if(state.filePath.startsWith('assets/')) {
        final ByteData assetBytes = await rootBundle.load(state.filePath);
        final tempFile = File('${(await getTemporaryDirectory()).path}/${state.filePath}');
        final file = await tempFile.writeAsBytes(assetBytes.buffer.asUint8List(assetBytes.offsetInBytes, assetBytes.lengthInBytes));
        
        return file;
      } else {
        return File(state.filePath);
      }
    } catch (error) {
      print('error at ContentSendController.getContentFile >>> $error');
    }
    return null;
  }

}