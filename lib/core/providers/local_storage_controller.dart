import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_storage_controller.g.dart';



@riverpod
class LocalStorageController extends _$LocalStorageController {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _permissionState;

  @override
  List<AssetEntity> build() {
    ref.onDispose(() {
      print('LocalStorageController Dispose!!!');
    });
    print('LocalStorageController Build!!!');
    initialize();
    return List.empty();
  }

  Future<void> initialize() async {
    try {
      _permissionState = await PhotoManager.requestPermissionExtend();
      if(_permissionState.isAuth) {
        var files = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
        state = files;
        _pageIndex++;
      }
    } catch (error) {
      print('Error at LocalStorageController.initialize >>> $error');
    }
  }

  Future<void> loadNext() async {
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