import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_storage_controller.g.dart';



@riverpod
class GalleryImageController extends _$GalleryImageController {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _permissionState;

  @override
  List<AssetEntity> build() {
    ref.onDispose(() {
      print('GalleryImageController Dispose');
    });
    print('GalleryImageController Build');
    initialize();
    return List.empty();
  }

  void initialize() async {
    try {
      _permissionState = await PhotoManager.requestPermissionExtend();
      if(_permissionState.isAuth) {
        state = await PhotoManager.getAssetListPaged(
          page: _pageIndex, 
          pageCount: _pageCount, 
          type: RequestType.image
        );
        _pageIndex = 1;
      }
    } catch (error) {
      print('Error at GalleryImageController.initialize >>> $error');
    }
  }

  void loadNext() async {
    try {
      if(_permissionState.isAuth) {
        var images = await PhotoManager.getAssetListPaged(
          page: _pageIndex, 
          pageCount: _pageCount, 
          type: RequestType.image
        );
        state = [...state, ...images];
        _pageIndex++;
      }
    } catch (error) {
      print('Error at GalleryImageController.loadNext >>> $error');
    }
  }

}

@riverpod
class GalleryController extends _$GalleryController {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _permissionState;

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
      _permissionState = await PhotoManager.requestPermissionExtend();
      if(_permissionState.isAuth) {
        state = await PhotoManager.getAssetListPaged(
          page: _pageIndex, 
          pageCount: _pageCount
        );
        _pageIndex = 1;
      }
    } catch (error) {
      print('Error at GalleryController.initialize >>> $error');
    }
  }

  void loadNext() async {
    try {
      if(_permissionState.isAuth) {
        var images = await PhotoManager.getAssetListPaged(
          page: _pageIndex, 
          pageCount: _pageCount
        );
        state = [...state, ...images];
        _pageIndex++;
      }
    } catch (error) {
      print('Error at GalleryController.loadNext >>> $error');
    }
  }

}