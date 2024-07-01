import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/content_info.dart';
import '../repository/content_repository.dart';

part 'content_list_controller.g.dart';



@riverpod 
class ContentListController extends _$ContentListController {

  late ContentRepository _contentRepository;


  Future<List<ContentInfo>> build() async {
    ref.onDispose(() {
      print('ContentListController Dispose!!!');
    });
    print('ContentListController Build!!!');
    _contentRepository = ContentRepository();
    return await getContents();
  }


  Future<List<ContentInfo>> getContents() async {
    return await _contentRepository.getAll();
  }

  Future<ContentInfo?> createContent() async {
    return await _contentRepository.create();
  }

  Future<void> deleteContent(List<String> contentIds) async {
    for(var contentId in contentIds) {
      await _contentRepository.delete(contentId);
    }
    state = AsyncValue.data(await getContents());
  }

  Future<void> deleteAllContent() async {
    await _contentRepository.deleteAll();
    state = AsyncValue.data(List.empty());
  }

}