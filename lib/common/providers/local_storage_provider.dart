import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_storage_provider.g.dart';



@riverpod
class LocalStorage extends _$LocalStorage {

  int _pageIndex = 0;
  final int _pageCount = 20;
  late PermissionState _storagePermission;


  @override
  List<AssetEntity> build() {
    ref.onDispose(() {
      print("<<<<<<< LocalStorageController dispose <<<<<<<");
    });
    print("<<<<<<< LocalStorageController build <<<<<<<");
    initialize();
    return List.empty();
  }

  Future<void> initialize() async {
    _storagePermission = await PhotoManager.requestPermissionExtend();
    if(_storagePermission.isAuth) {
      state = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
      // _pageIndex++;
    }
  }

  Future<void> nextLoad() async {
    if(_storagePermission.isAuth) {
      var nextFiles = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
      state = [...state, ...nextFiles];
      _pageIndex++;
    }
  }

}