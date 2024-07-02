import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/content_info.dart';
import '../repository/content_repository.dart';

part 'content_info_controller.g.dart';



@riverpod 
class ContentInfoController extends _$ContentInfoController {

  late ContentRepository _contentRepository;


  @override
  ContentInfo build() {
    ref.onDispose(() {
      print('ContentInfoController dispose');
    });
    print('ContentInfoController build');
    _contentRepository = ContentRepository();
    return ContentInfo(contentId: '');
  }


  void setContent(ContentInfo content) {
    state = content;
  }

  void change(ContentInfo updateContent) {
    state = updateContent;
  }

  Future<void> saveChange() async {
    try {
      state = (await _contentRepository.update(state.contentId, state))!;
    } catch (error) {
      print('error at ContentInfoController.saveChange >>> $error');
    }
  }

  void setName(String name) {
    state = state.copyWith(contentName: name);
  }

  void setWidth(int width) {
    state = state.copyWith(width: width);
  }

  void setHeight(int height) {
    state = state.copyWith(height: height);
  }

  void setX(int x) {
    state = state.copyWith(x: x);
  }

  void setY(int y) {
    state = state.copyWith(y: y);
  }

  void setReverse(bool reverse) {
    state = state.copyWith(isReverse: reverse);
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