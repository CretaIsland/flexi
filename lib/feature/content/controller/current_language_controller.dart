import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/current_language_repository.dart';

part 'current_language_controller.g.dart';



final selectInputLanguageProvider = StateProvider<Map<String, String>>((ref) => {});
final selectOutputLanguageProvider = StateProvider<Map<String, String>>((ref) => {});


@riverpod
class CurrentInputLanguagesController extends _$CurrentInputLanguagesController {

  late CurrentLanguageRepository _currentLanguagesRepository;


  @override
  List<Map<String, String>> build() {
    ref.onDispose(() {
      print("<<<<<<< CurrentInputLanguagesController dispose <<<<<<<");
    });
    print("<<<<<<< CurrentInputLanguagesController build <<<<<<<");
    _currentLanguagesRepository = CurrentLanguageRepository();
    getCurrentLanguages();
    return List.empty();
  }

  Future<void> getCurrentLanguages() async {
    state = await _currentLanguagesRepository.getInputLangs();
  }

  Future<void> saveChange() async {
    await _currentLanguagesRepository.updateInputLangs(state);
  }

  Future<void> updateCurrentLanguage(Map<String, String> currentLanguage) async {
    if(state.isNotEmpty) {
      if(state.length >= 3) state.removeAt(0);
      state = [...state, currentLanguage];
    } else {
      state = [currentLanguage];
    }
  }

}

@riverpod
class CurrentOutputLanguagesController extends _$CurrentOutputLanguagesController {

  late CurrentLanguageRepository _currentLanguagesRepository;


  @override
  List<Map<String, String>> build() {
    ref.onDispose(() {
      print("<<<<<<< CurrentOutputLanguagesController dispose <<<<<<<");
    });
    print("<<<<<<< CurrentOutputLanguagesController build <<<<<<<");
    _currentLanguagesRepository = CurrentLanguageRepository();
    getCurrentLanguages();
    return List.empty();
  }

  Future<void> getCurrentLanguages() async {
    state = await _currentLanguagesRepository.getOutputLangs();
  }

  Future<void> saveChange() async {
    await _currentLanguagesRepository.updateOutputLangs(state);
  }

  Future<void> updateCurrentLanguage(Map<String, String> currentLanguage) async {
    if(state.isNotEmpty) {
      if(state.length >= 3) state.removeAt(0);
      state = [...state, currentLanguage];
    } else {
      state = [currentLanguage];
    }
  }

}
