import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/content_info.dart';
import 'content_info_controller.dart';

part 'background_edit_controller.g.dart';



final tabIndexProvider = StateProvider<int>((ref) => 1);


@riverpod 
class BackgroundEditController extends _$BackgroundEditController {

  @override
  ContentInfo build() {
    ref.onDispose(() {
      print("<<<<<<< BackgroundEditController dispose <<<<<<<");
    });
    print("<<<<<<< BackgroundEditController build <<<<<<<");
    return ref.read(contentInfoControllerProvider)!;
  }

  // background 색깔로 변경하기
  void setBackgroundColor(Color color) {
    state = state.copyWith(
      backgroundType: 'color', 
      backgroundColor: color.toString(),
      filePath: '',
      fileName: '',
      fileThumbnail: ''
    );
  }

  // background 콘텐츠로 변경하기
  void setBackgroundContent(String contentType, String contentPath, String contentName, Uint8List contentThumbnail) {
    state = state.copyWith(
      backgroundType: contentType, 
      filePath: contentPath,
      fileName: contentName,
      fileThumbnail: base64Encode(contentThumbnail)
    );
  }

}


@riverpod 
class LocalStorageController extends _$LocalStorageController {

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