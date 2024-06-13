import 'package:intl/intl.dart';
import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';
import '../model/content_info.dart';



class ContentRespository {

  final _contentStore = stringMapStoreFactory.store('content');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  Future<ContentInfo?> create() async {
    try {
      DateTime now = DateTime.now();
      ContentInfo newContent = ContentInfo(contentId: now.toString(), contentName: 'New Content ${DateFormat('yy/MM/dd HH:mm:ss').format(now)}');
      var result = await _contentStore.record(newContent.contentId).put(await _dbClient, newContent.toJson());
      return ContentInfo.fromJson(result);
    } catch (error) {
      print('error at ContentRepository.create >>> $error');
    }
    return null;
  }

  Future<ContentInfo?> get(String contentId) async {
    try {
      var result = await _contentStore.record(contentId).get(await _dbClient);
      return ContentInfo.fromJson(result!);
    } catch (error) {
      print('error at ContentRepository.get >>> $error');
    }
    return null;
  }

  Future<List<ContentInfo>> getAll() async {
    try {
      var results = await _contentStore.find(await _dbClient);
      return results.map((result) => ContentInfo.fromJson(result.value)).toList();
    } catch (error) {
      print('error at ContentRepository.getAll >>> $error');
    }
    return List.empty();
  }

  Future<ContentInfo?> update(String contentId, ContentInfo updateContent) async {
    try {
      var result = await _contentStore.record(contentId).update(await _dbClient, updateContent.toJson());
      return ContentInfo.fromJson(result!);
    } catch (error) {
      print('error at ContentRepository.update >>> $error');
    }
    return null;
  }

  Future<void> delete(String contentId) async{
    try {
      await _contentStore.record(contentId).delete(await _dbClient);
    } catch (error) {
      print('error at ContentRepository.delete >>> $error');
    }
  }

  Future<void> deleteAll() async{
    try {
      await _contentStore.delete(await _dbClient);
    } catch (error) {
      print('error at ContentRepository.deleteAll >>> $error');
    }
  }

}