


import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';
import '../model/content_info.dart';

class ContentRepository {

  static const String storeName = 'contents';
  final _contentStore = stringMapStoreFactory.store(storeName);

  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  // 콘텐츠 생성
  Future<ContentInfo?> create() async {
    try {
      String contentId = DateTime.now().toString();
      ContentInfo newContent = ContentInfo(id: contentId);
      var result = await _contentStore.record(contentId).put(await _dbClient, newContent.toJson());
      return ContentInfo.fromJson(result);
    } catch (error) {
      print('error at ContentRepository.create >>> $error');
    }
    return null;
  }

  // 특정 콘텐츠 조회
  Future<ContentInfo?> get(String contentId) async {
    try {
      var result = await _contentStore.record(contentId).get(await _dbClient);
    return ContentInfo.fromJson(result!);
    } catch (error) {
      print('error at ContentRepository.get >>> $error');
    }
    return null;
  }

  // 모든 콘텐츠 조회
  Future<List<ContentInfo>> getAllDatas() async {
    try {
      var results = await _contentStore.find(await _dbClient);
      return results.map((data) => ContentInfo.fromJson(data.value)).toList();
    } catch (error) {
      print('error at ContentRepository.getAllDatas >>> $error');
    }
    return List.empty();
  }
  
  // 콘텐츠 데이터 수정
  Future<ContentInfo?> update(String contentId, ContentInfo editContent) async {
    try {
      var result = await _contentStore.record(contentId).update(await _dbClient, editContent.toJson());
      return ContentInfo.fromJson(result!);
    } catch (error) {
      print('error at ContentRepository.update >>> $error');
    }
    return null;
  }

  // 특정 콘텐츠 삭제
  Future<void> delete(String contentId) async {
    try {
      await _contentStore.record(contentId).delete(await _dbClient);
    } catch (error) {
      print('error at ContentRepository.delete >>> $error');
    }
  }

  // 모든 콘텐츠 삭제
  Future<void> deleteAllDatas() async {
    try {
      await _contentStore.delete(await _dbClient);
    } catch (error) {
      print('error at ContentRepository.delete >>> $error');
    }
  }

}