import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:photo_manager/photo_manager.dart';

part 'local_storage_controller.g.dart';



@riverpod
class LocalStorageImageController extends _$LocalStorageImageController {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _permissionState;

  @override
  List<AssetEntity> build() {
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
      print('Error at LocalStorageImageController.initialize >>> $error');
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
      print('Error at LocalStorageImageController.loadNext >>> $error');
    }
  }

}

@riverpod
class LocalStorageController extends _$LocalStorageController {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _permissionState;

  @override
  List<AssetEntity> build() {
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
      print('Error at LocalStorageController.initialize >>> $error');
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
      print('Error at LocalStorageController.loadNext >>> $error');
    }
  }

}