import 'package:sembast/sembast.dart';
import 'package:intl/intl.dart';

import '../../database/app_database.dart';
import '../model/content_model.dart';



class ContentRepository {

  final _store = stringMapStoreFactory.store('content');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  Future<ContentModel?> create() async {
    try {
      DateTime now = DateTime.now();
      ContentModel newContent = ContentModel(
        contentId: now.toString(), 
        contentName: 'New Content ${DateFormat('yyyy/MM/dd HH:mm:ss').format(now)}',
        language: 'en-US'
      );
      var result = await _store.record(newContent.contentId).put(await _dbClient, newContent.toJson());
      return ContentModel.fromJson(result);
    } catch (error) {
      print('error at ContentRepository.create >>> $error');
    }
    return null;
  }
  
  Future<List<ContentModel>> getAll() async {
    try {
      var results = await _store.find(await _dbClient);
      return results.map((element) => ContentModel.fromJson(element.value)).toList();
    } catch (error) {
      print('error at ContentRepository.getAll >>> $error');
    }
    return List.empty();
  }

  Future<ContentModel?> update(ContentModel updateContent) async {
    try {
      var result = await _store.record(updateContent.contentId).update(await _dbClient, updateContent.toJson());
      return ContentModel.fromJson(result!);
    } catch (error) {
      print('error at ContentRepository.create >>> $error');
    }
    return null;
  }
  
  Future<void> delete(contentId) async {
    try {
      await _store.record(contentId).delete(await _dbClient);
    } catch (error) {
      print('error at ContentRepository.delete >>> $error');
    }
  }

    Future<void> deleteAll() async {
    try {await _store.delete(await _dbClient);
    } catch (error) {
      print('error at ContentRepository.deleteAll >>> $error');
    }
  }

}