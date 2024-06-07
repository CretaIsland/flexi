import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/content_info.dart';
import '../repository/content_respository.dart';

part 'content_info_controller.g.dart';



@riverpod
class ContentInfoController extends _$ContentInfoController {

  late ContentRespository _contentRespository;
  ContentInfo? _originalContent;


  @override
  ContentInfo? build() {
    ref.onDispose(() {
      print("<<<<<<< ContentInfoController dispose <<<<<<<");
    });
    print("<<<<<<< ContentInfoController build <<<<<<<");
    _contentRespository = ContentRespository();
    return null;
  }


  void setContent(ContentInfo targetContent) {
    state = targetContent;
    _originalContent = targetContent;
  }

  void undo() {
    state = _originalContent;
  }

  void change(ContentInfo updateContent) {
    state = updateContent;
    _originalContent = updateContent;
  }

  Future<void> saveChange() async {
    state = await _contentRespository.update(state!.contentId, state!);
    _originalContent = state;
  }

  
  // =================== 콘텐츠 메타데이터 수정 =================== 
  // 콘텐츠 이름 변경
  void setName(String name) {
    state = state!.copyWith(contentName: name);
  }

  // 콘텐츠 가로 사이즈 변경
  void setWidth(int width) {
    state = state!.copyWith(width: width);
  }
  
  // 콘텐츠 세로 사이즈 변경
  void setHeight(int height) {
    state = state!.copyWith(height: height);
  }

  // 콘텐츠 X 좌표 변경
  void setX(int x) {
    state = state!.copyWith(x: x);
  }

  // 콘텐츠 Y 좌표 변경
  void setY(int y) {
    state = state!.copyWith(y: y);
  }

  // 콘텐츠 리버스여부 변경
  void setReverse(bool isReverse) {
    state = state!.copyWith(isReverse: isReverse);
  }
  
}