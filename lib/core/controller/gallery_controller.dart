import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gallery_controller.g.dart';



@riverpod 
class GalleryController extends _$GalleryController {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _permission;

  @override
  List<AssetEntity> build() {
    ref.onDispose(() {
      print('GalleryController Dispose');
    });
    print('GalleryController Build');
    initialize();
    return List.empty();
  }

  void initialize() async {
    try {
      _permission = await PhotoManager.requestPermissionExtend();
      if(_permission.isAuth) {
        state = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
        _pageIndex = 1;
      }
    } catch (error) {
      print('Error at GalleryController.initialize >>> $error');
    }
  }

  void loadNext() async {
    try {
      if(_permission.isAuth) {
        var assets = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
        state = [...state, ...assets];
        _pageIndex++;
      }
    } catch (error) {
      print('Error at GalleryController.loadNext >>> $error');
    }
  }

}