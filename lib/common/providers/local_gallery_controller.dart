import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_gallery_controller.g.dart';



@riverpod 
class LocalGalleryController extends _$LocalGalleryController {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _storagePermission;


  @override
  List<AssetEntity> build() {
    ref.onDispose(() {
      print('LocalGalleryController Dispose!!!');
    });
    print('LocalGalleryController Build!!!');
    initialize();
    return List.empty();
  }


  Future<void> initialize() async {
    try {
      _storagePermission = await PhotoManager.requestPermissionExtend();
      if(_storagePermission.isAuth) {
        var files = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
        _pageIndex = 1;
        state = files;
      }
    } catch (error) {
      print('error at LocalGalleryController.initialize >>> $error');
    }
  }

  Future<void> nextLoad() async {
    try {
      if(_storagePermission.isAuth) {
        var nextFiles = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
        state = [...state, ...nextFiles];
        _pageIndex++;
      }
    } catch (error) {
      print('error at LocalGalleryController.nextLoad >>> $error');
    }
  }

}