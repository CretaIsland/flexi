import 'package:intl/intl.dart';
import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';
import '../model/content_info.dart';



class ContentRepository {

  final _store = stringMapStoreFactory.store('content');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  Future<ContentInfo?> create() async {
    try {
      DateTime now = DateTime.now();
      ContentInfo newContent = ContentInfo(contentId: now.toString(), contentName: 'New Content ${DateFormat('yy/MM/dd HH:mm:ss').format(now)}', language: 'en-US');
      var result = await _store.record(newContent.contentId).put(await _dbClient, newContent.toJson());
      return ContentInfo.fromJson(result);
    } catch (error) {
      print('error at ContentRepository.create >>> $error');
    }
    return null;
  }

  Future<ContentInfo?> get(String contentId) async {
    try {
      var result = await _store.record(contentId).get(await _dbClient);
      return ContentInfo.fromJson(result!);
    } catch (error) {
      print('error at ContentRepository.get >>> $error');
    }
    return null;
  }

  Future<List<ContentInfo>> getAll() async {
    try {
      var results = await _store.find(await _dbClient);
      return results.map((element) => ContentInfo.fromJson(element.value)).toList();
    } catch (error) {
      print('error at ContentRepository.getAll >>> $error');
    }
    return List.empty();
  }

  Future<ContentInfo?> update(String contentId, ContentInfo updateContent) async {
    try {
      var result = await _store.record(contentId).update(await _dbClient, updateContent.toJson());
      return ContentInfo.fromJson(result!);
    } catch (error) {
      print('error at ContentRepository.update >>> $error');
    }
    return null;
  }

  Future<void> delete(String contentId) async {
    try {
      await _store.record(contentId).delete(await _dbClient);
    } catch (error) {
      print('error at ContentRepository.delete >>> $error');
    }
  }

  Future<void> deleteAll() async {
    try {
      await _store.delete(await _dbClient);
    } catch (error) {
      print('error at ContentRepository.deleteAll >>> $error');
    }
  }

}