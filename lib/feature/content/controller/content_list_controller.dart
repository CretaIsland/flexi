import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/content_model.dart';
import '../repository/content_repository.dart';

part 'content_list_controller.g.dart';



final selectContentsProvider = StateProvider<List<String>>((ref) => List.empty());

@riverpod
class ContentListController extends _$ContentListController {

  late ContentRepository _repository;

  Future<List<ContentModel>> build() async {
    ref.onDispose(() {
      print('ContentListController Dispose');
    });
    print('ContentListController Build');
    _repository = ContentRepository();
    return await getContents();
  }

  Future<List<ContentModel>> getContents() async {
    return await _repository.getAll();
  }

  Future<ContentModel?> createContent() async {
    return await _repository.create();
  }

  Future<void> deleteContent(List<String> contentIds) async {
    for(var contentId in contentIds) {
      await _repository.delete(contentId);
    }
    state = AsyncValue.data(await getContents());
  }

  Future<void> deleteAllContent() async {
    await _repository.deleteAll();
    state = AsyncValue.data(List.empty());
  }

}