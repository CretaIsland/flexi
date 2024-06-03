import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/content_info.dart';
import '../repository/content_repository.dart';

part 'content_list_controller.g.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);
final selectContentsProvider = StateProvider<List<String>>((ref) => List.empty());


@riverpod
class ContentListController extends _$ContentListController {

  late ContentRepository _contentRepository;


  Future<List<ContentInfo>> build() async {
    ref.onDispose(() {
      print("<<<<<<< ContentListController dispose <<<<<<<");
    });
    print("<<<<<<< ContentListController build <<<<<<<");
    _contentRepository = ContentRepository();
    return await getAllContents();
  }


  Future<List<ContentInfo>> getAllContents() async {
    return await _contentRepository.getAllDatas();
  }

  Future<ContentInfo?> createContent() async {
    return await _contentRepository.create();
  }

  Future<void> deleteContents(List<String> contentIds) async {
    for(var contentId in contentIds) {
      await _contentRepository.delete(contentId);
    }
    state = AsyncValue.data(await getAllContents());
  }

  Future<void> deleteAllContents() async {
    await _contentRepository.deleteAllDatas();
    state = AsyncValue.data(List.empty());
  }

}