import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/content_info.dart';
import '../repository/content_repository.dart';

part 'content_info_controller.g.dart';


@riverpod
class ContentInfoController extends _$ContentInfoController {

  late ContentRepository _contentRepository;
  ContentInfo? _originalContent; 


  @override
  ContentInfo? build() {
    ref.onDispose(() {
      print("<<<<<<< ContentEditController dispose <<<<<<<");
    });
    print("<<<<<<< ContentEditController build <<<<<<<");
    _contentRepository = ContentRepository();
    return null;
  }

  // 현재 편집중인 콘텐츠의 모델을 상태 값으로 가지고 있어야함.
  void setContent(ContentInfo selectContent) {
    state = selectContent;
    _originalContent = selectContent;
  }

  // 수정사항 저장
  Future<void> saveChange() async {
    state = await _contentRepository.update(state!.id, state!);
    _originalContent = state;
  }

  // 수정사항 삭제
  void undo() {
    state = _originalContent;
  }

  // 수정사항 적용
  void change(ContentInfo editContent) {
    state = editContent;
    _originalContent = state;
  }

  // =================== 콘텐츠 메타데이터 수정 ===================

  // 콘텐츠 리버스여부 변경
  void setName(String name) {
    state = state!.copyWith(name: name);
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