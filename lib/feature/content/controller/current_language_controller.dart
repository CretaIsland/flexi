import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/current_language_repository.dart';

part 'current_language_controller.g.dart';



final selectInputLanguageProvider = StateProvider<Map<String, String>>((ref) => {});
final selectOutputLanguageProvider = StateProvider<Map<String, String>>((ref) => {});

@riverpod
class CurrentInputLanguagesController extends _$CurrentInputLanguagesController {

  late CurrentLanguageRepository _repository;

  @override
  List<Map<String, String>> build() {
    ref.onDispose(() {
      print("CurrentInputLanguagesController Dispose");
    });
    print("CurrentInputLanguagesController Build");
    _repository = CurrentLanguageRepository();
    getCurrentLanguages();
    return List.empty();
  }

  Future<void> getCurrentLanguages() async {
    state = await _repository.getInputLangs();
  }

  Future<void> saveChange() async {
    await _repository.updateInputLangs(state);
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

  late CurrentLanguageRepository _repository;

  @override
  List<Map<String, String>> build() {
    ref.onDispose(() {
      print("CurrentOutputLanguagesController Dispose");
    });
    print("CurrentOutputLanguagesController Build");
    _repository = CurrentLanguageRepository();
    getCurrentLanguages();
    return List.empty();
  }

  Future<void> getCurrentLanguages() async {
    state = await _repository.getOutputLangs();
  }

  Future<void> saveChange() async {
    await _repository.updateOutputLangs(state);
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