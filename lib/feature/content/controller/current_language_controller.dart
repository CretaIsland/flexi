import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/languages_repository.dart';

part 'current_language_controller.g.dart';



final selectInputLanguageProvider = StateProvider<Map<String, String>>((ref) => {});
final selectOutputLanguageProvider = StateProvider<Map<String, String>>((ref) => {});


@riverpod
class InputLanguagesController extends _$InputLanguagesController {

  late LanguageRepository _languageRepository;
  @override
  List<Map<String, String>> build() {
    ref.onDispose(() {
      print("<<<<<<< InputLanguagesController dispose <<<<<<<");
    });
    print("<<<<<<< InputLanguagesController build <<<<<<<");
    _languageRepository = LanguageRepository();
    getCurrentLanguages();
    return List.empty();
  }

  Future<void> getCurrentLanguages() async {
    state = await _languageRepository.getInputLanguages();
  }

  Future<void> updateCurrentLanguage(Map<String, String> currentLanguage) async {
    if(state.isNotEmpty) {
      if(state.length >= 3) state.removeAt(0);
      state = [...state, currentLanguage];
    } else {
      state = [currentLanguage];
    }
  }

  Future<void> saveChange() async {
    await _languageRepository.updateInputLanguages(state);
  }

}

@riverpod
class OutputLanguagesController extends _$OutputLanguagesController {

  late LanguageRepository _languageRepository;
  @override
  List<Map<String, String>> build() {
    ref.onDispose(() {
      print("<<<<<<< OutputLanguagesController dispose <<<<<<<");
    });
    print("<<<<<<< OutputLanguagesController build <<<<<<<");
    _languageRepository = LanguageRepository();
    getCurrentLanguages();
    return List.empty();
  }

  Future<void> getCurrentLanguages() async {
    state = await _languageRepository.getOutputLanguages();
  }

  Future<void> updateCurrentLanguage(Map<String, String> currentLanguage) async {
    if(state.isNotEmpty) {
      if(state.length >= 3) state.removeAt(0);
      state = [...state, currentLanguage];
    } else {
      state = [currentLanguage];
    }
  }

  Future<void> saveChange() async {
    await _languageRepository.updateOutputLanguages(state);
  }

}