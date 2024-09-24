import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_storage_controller.g.dart';



@riverpod
class GalleryImageControlller extends _$GalleryImageControlller {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _permissionState;


  @override
  List<AssetEntity> build() {
    ref.onDispose(() {
      print('GalleryImageControlller Dispose');
    });
    print('GalleryImageControlller Build');
    initialize();
    return List.empty();
  }

  void initialize() async {
    try {
      _permissionState = await PhotoManager.requestPermissionExtend();
      if(_permissionState.isAuth) {
        state = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount, type: RequestType.image);
        _pageIndex = 1;
      }
    } catch (error) { 
      print('Error at GalleryImageControlller.initialize >>> $error');
    }
  }

  void loadNext() async {
    try {
      if(_permissionState.isAuth) {
        var files = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount, type: RequestType.image);
        state = [...state, ...files];
        _pageIndex++;
      }
    } catch (error) {
      print('Error at GalleryImageControlller.loadNext >>> $error');
    }
  }

}

@riverpod
class GalleryControlller extends _$GalleryControlller {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _permissionState;


  @override
  List<AssetEntity> build() {
    ref.onDispose(() {
      print('GalleryControlller Dispose');
    });
    print('GalleryControlller Build');
    initialize();
    return List.empty();
  }

  void initialize() async {
    try {
      _permissionState = await PhotoManager.requestPermissionExtend();
      if(_permissionState.isAuth) {
        state = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
        _pageIndex = 1;
      }
    } catch (error) { 
      print('Error at GalleryControlller.initialize >>> $error');
    }
  }

  void loadNext() async {
    try {
      if(_permissionState.isAuth) {
        var files = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
        state = [...state, ...files];
        _pageIndex++;
      }
    } catch (error) {
      print('Error at GalleryControlller.loadNext >>> $error');
    }
  }

}