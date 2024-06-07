import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/content_info.dart';
import '../repository/content_respository.dart';

part 'content_list_controller.g.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);
final selectContentsProvider = StateProvider<List<String>>((ref) => List.empty());


@riverpod
class ContentListController extends _$ContentListController {

  late ContentRespository _contentRespository;


  @override
  Future<List<ContentInfo>> build() async {
    ref.onDispose(() {
      print("<<<<<<< ContentListController dispose <<<<<<<");
    });
    print("<<<<<<< ContentListController build <<<<<<<");
    _contentRespository = ContentRespository();
    return await getContents();
  }


  Future<List<ContentInfo>> getContents() async {
    return await _contentRespository.getAll();
  }

  Future<ContentInfo?> createContent() async {
    return await _contentRespository.create();
  }

  Future<void> deleteContents(List<String> contentIds) async {
    for(var contentId in contentIds) {
      await _contentRespository.delete(contentId);
    }
    state = AsyncValue.data(await getContents());
  }

  Future<void> deleteAll() async {
    await _contentRespository.deleteAll();
    state = AsyncValue.data(List.empty());
  }

}