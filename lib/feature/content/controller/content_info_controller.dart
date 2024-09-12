import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/content_model.dart';
import '../repository/content_repository.dart';

part 'content_info_controller.g.dart';



@riverpod 
class ContentInfoController extends _$ContentInfoController {

  late ContentRepository _contentRepository;


  @override
  ContentModel build() {
    ref.onDispose(() {
      print('ContentInfoController Dispose!!!');
    });
    print('ContentInfoController Build!!!');
    _contentRepository = ContentRepository();
    return ContentModel(contentId: '');
  }

  Future<void> save() async {
    await _contentRepository.update(state);
  }

  void setContent(ContentModel targetContent) {
    state = targetContent;
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
        final byteData = await rootBundle.load(state.filePath);

        // 임시 디렉토리 생성 및 임시 파일 생성
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/${state.fileName}');

        // 임시 파일에 이미지 데이터 쓰기
        await tempFile.writeAsBytes(byteData.buffer.asUint8List());
        return tempFile;
      } else {
        return File(state.filePath);
      }
    } catch (error) {
      print('Error at ContentSendController.getContentFile >>> $error');
    }
    return null;
  }

}