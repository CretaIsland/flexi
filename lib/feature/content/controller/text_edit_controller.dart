import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

import '../model/content_info.dart';
import '../repository/current_languages_repository.dart';
import 'content_info_controller.dart';

part 'text_edit_controller.g.dart';



final keyboardEventProvider = StateProvider<FocusNode>((ref) => FocusNode());
final sttModeProvider = StateProvider<bool>((ref) => true);
final isSpeakingProvider = StateProvider<bool>((ref) => false);


@riverpod
class TextEditController extends _$TextEditController {
 

  @override
  ContentInfo build() {
    return ref.read(contentInfoControllerProvider)!;
  }


  // 텍스트 내용 변경하기
  void setText(String text) {
    state = state.copyWith(text: text);
  }

  // 폰트 색깔 변경하기
  void setTextColor(Color color) {
    state = state.copyWith(textColor: color.toString());
  }

  // 폰트 사이즈 변경하기
  void setTextSize(String size) {
    if(size == 's') {
      state = state.copyWith(textSize: state.height * .4, textSizeType: 's');
    } else if(size == 'm') {
      state = state.copyWith(textSize: state.height * .6, textSizeType: 'm');
    } else if(size == 'l') {
      state = state.copyWith(textSize: state.height * .8, textSizeType: 'l');
    }
  }

  // 폰트 굵기 변경하기
  void setTextWeight(bool isBold) {
    state = state.copyWith(bold: isBold);
  }

  // 폰트 기울기 여부 변경하기
  void setTextItalic(bool isItalic) {
    state = state.copyWith(italic: isItalic);
  }

}


final selectInputLanguageProvider = StateProvider<Map<String, String>>((ref) => {});
final selectOutputLanguageProvider = StateProvider<Map<String, String>>((ref) => {});


@riverpod
class CurrentInputLanguagesController extends _$CurrentInputLanguagesController {

  late CurrentLanguagesRepository _currentLanguagesRepository;


  @override
  List<Map<String, String>> build() {
    _currentLanguagesRepository = CurrentLanguagesRepository();
    getCurrentLanguages();
    return List.empty();
  }

  Future<void> getCurrentLanguages() async {
    state = await _currentLanguagesRepository.getInputLanguages();
  }

  Future<void> saveChange() async {
    await _currentLanguagesRepository.updateInputLanguages(state);
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

  late CurrentLanguagesRepository _currentLanguagesRepository;


  @override
  List<Map<String, String>> build() {
    _currentLanguagesRepository = CurrentLanguagesRepository();
    getCurrentLanguages();
    return List.empty();
  }

  Future<void> getCurrentLanguages() async {
    state = await _currentLanguagesRepository.getOutputLanguages();
  }

  Future<void> saveChange() async {
    await _currentLanguagesRepository.updateOutputLanguages(state);
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
class SpeechToTextController extends _$SpeechToTextController {

  late SpeechToText _stt;
  bool _sttInit = false;


  @override
  String build() {
    _stt = SpeechToText();
    _stt.initialize().then((value) => _sttInit = value);
    return '';
  }

  // 녹음 시작하기
  void startRecord(String localeId) async {
    try {
      if(_sttInit) {
        _stt.listen(
          listenOptions: SpeechListenOptions(cancelOnError: true),
          localeId: localeId,
          onResult: (value) => state = value.recognizedWords
        );
      }
    } catch (error) {
      print('error during TextEditController.startRecord >>> $error');
    }
  }

  // 녹음 종료하기
  void stopRecord() async {
    if(_sttInit) {
      await _stt.stop();
    }
  }

}

@riverpod
class TextTranslateController extends _$TextTranslateController {

  late GoogleTranslator _translator;

  @override
  String build() {
    _translator = GoogleTranslator();
    return '';
  }

  // 번역하기
  Future<void> translate(String inputText, String from, String to) async {
    try {
      var outputText = await _translator.translate(
        inputText,
        from: from, 
        to: to
      );
      state = outputText.text;
    } catch (error) {
      print('error during TextEditController.translate >>> $error');
    }
  }

}