import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';



class CurrentLanguageRepository {

  final _inputLangStore = intMapStoreFactory.store('current_input_langs');
  final _outputLangStore = intMapStoreFactory.store('current_output_langs');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  Future<List<Map<String, String>>> getInputLangs() async {
    try {
      var results = await _inputLangStore.find(await _dbClient);
      return results.map((element) => Map<String, String>.from(element.value)).toList();
    } catch (error) {
      print('error at LanguageRepository.getInputLangs >>> $error');
    }
    return List.empty();
  }

  Future<List<Map<String, String>>> getOutputLangs() async {
    try {
      var results = await _outputLangStore.find(await _dbClient);
      return results.map((element) => Map<String, String>.from(element.value)).toList();
    } catch (error) {
      print('error at LanguageRepository.getOutputLangs >>> $error');
    }
    return List.empty();
  }

  Future<void> updateInputLangs(List<Map<String, String>> updateInputLangs) async {
    try {
      await _inputLangStore.delete(await _dbClient);
      await _inputLangStore.addAll(await _dbClient, updateInputLangs);
    } catch (error) {
      print('error at LanguageRepository.updateInputLangs >>> $error');
    }
  }

  Future<void> updateOutputLangs(List<Map<String, String>> updateOutputLangs) async {
    try {
      await _outputLangStore.delete(await _dbClient);
      await _outputLangStore.addAll(await _dbClient, updateOutputLangs);
    } catch (error) {
      print('error at LanguageRepository.updateOutputLangs >>> $error');
    }
  }

}