import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_storage_controller.g.dart';



@riverpod
class LocalStorageController extends _$LocalStorageController {

  int _pageIndex = 0;
  final int _pageCount = 30;
  late PermissionState _permission;


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
      _permission = await PhotoManager.requestPermissionExtend();
      if(_permission.isAuth) {
        var files = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
        _pageIndex = 1;
        state = files;
      }
    } catch (error) {
      print('error at LocalStorageController.initialize >>> $error');
    }
  }

  Future<void> nextLoad() async {
    try {
      if(_permission.isAuth) {
        var nextFiles = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
        state = [...state, ...nextFiles];
        _pageIndex++;
      }
    } catch (error) {
      print('error at LocalStorageController.nextLoad >>> $error');
    }
  }

}