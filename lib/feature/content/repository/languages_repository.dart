import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';



class LanguageRepository {

  static const String inputStoreName = 'currentInputLanguages';
  static const String outputStoreName = 'currentInputLanguages';
  final _inputStore = stringMapStoreFactory.store(inputStoreName);
  final _outputStore = stringMapStoreFactory.store(outputStoreName);

  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  // 최근 사용한 입력 언어 조회
  Future<List<Map<String, String>>> getInputLanguages() async {
    try {
      var results = await _inputStore.find(await _dbClient);
      return results.map((element) {
        return Map<String, String>.from(element.value);
      }).toList();
    } catch (error) {
      print('error at LanguageRepository.getAllDatas >>> $error');
    }
    return List.empty();
  }

  // 최근에 사용한 번역 언어 조회
  Future<List<Map<String, String>>> getOutputLanguages() async {
    try {
      var results = await _outputStore.find(await _dbClient);
      return results.map((element) {
        return Map<String, String>.from(element.value);
      }).toList();
    } catch (error) {
      print('error at LanguageRepository.getAllDatas >>> $error');
    }
    return List.empty();
  }

  // 최근 사용한 입력 언어 갱신
  Future<void> updateInputLanguages(List<Map<String, String>> currentLanguages) async {
    try {
      await _inputStore.delete(await _dbClient);
      _inputStore.addAll(await _dbClient, currentLanguages);
    } catch (error) {
      print('error at LanguageRepository.update >>> $error');
    }
  }

  // 최근에 사용한 번역 언어 수정
  Future<void> updateOutputLanguages(List<Map<String, String>> currentLanguages) async {
    try {
      await _outputStore.delete(await _dbClient);
      _outputStore.addAll(await _dbClient, currentLanguages);
    } catch (error) {
      print('error at LanguageRepository.update >>> $error');
    }
  }

}