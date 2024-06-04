import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';



class CurrentLanguagesRepository {

  final _inputLanguagesStore = stringMapStoreFactory.store('current_input_languages');
  final _outputLanguagesStore = stringMapStoreFactory.store('current_output_languages');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  Future<List<Map<String, String>>> getInputLanguages() async {
    try {
      var results = await _inputLanguagesStore.find(await _dbClient);
      return results.map((result) => Map<String, String>.from(result.value)).toList();
    } catch (error) {
      print('error at CurrentLanguagesRepository.getInputLanguages >>> $error');
    }
    return List.empty();
  }

  Future<List<Map<String, String>>> getOutputLanguages() async {
    try {
      var results = await _outputLanguagesStore.find(await _dbClient);
      return results.map((result) => Map<String, String>.from(result.value)).toList();
    } catch (error) {
      print('error at CurrentLanguagesRepository.getOutputLanguages >>> $error');
    }
    return List.empty();
  }

  Future<void> updateInputLanguages(List<Map<String, String>> updateInputLanguages) async {
    try {
      await _inputLanguagesStore.delete(await _dbClient);
      await _inputLanguagesStore.addAll(await _dbClient, updateInputLanguages);
    } catch (error) {
      print('error at CurrentLanguagesRepository.updateInputLanguages >>> $error');
    }
  }

  Future<void> updateOutputLanguages(List<Map<String, String>> updateOutputLanguages) async {
    try {
      await _outputLanguagesStore.delete(await _dbClient);
      await _outputLanguagesStore.addAll(await _dbClient, updateOutputLanguages);
    } catch (error) {
      print('error at CurrentLanguagesRepository.updateOutputLanguages >>> $error');
    }
  }

}