import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

import '../model/content_info.dart';
import 'content_info_controller.dart';

part 'text_edit_controller.g.dart';



final keyboardEventProvider = StateProvider<FocusNode>((ref) => FocusNode());
final sttModeProvider = StateProvider<bool>((ref) => true);
final isSpeakingProvider = StateProvider<bool>((ref) => false);


@riverpod
class TextEditController extends _$TextEditController {

  late GoogleTranslator _translator;
  late SpeechToText _stt;
  late String _recordResult;
  late String _translateResult;
  bool _sttInit = false;

  String recordResult () => _recordResult;
  String translateResult () => _translateResult;


  @override
  ContentInfo? build() {
    ref.onDispose(() {
      print("<<<<<<< TextEditController dispose <<<<<<<");
    });
    print("<<<<<<< TextEditController build <<<<<<<");
    _translator = GoogleTranslator();
    _stt = SpeechToText();
    _stt.initialize().then((value) => _sttInit = value);
    _recordResult = '';
    return ref.read(contentInfoControllerProvider);
  }


  // 폰트 색깔 변경하기
  void setTextColor(Color color) {
    state = state!.copyWith(textColor: color.toString());
  }

  // 폰트 사이즈 변경하기
  void setTextSize(String size) {
    if(size == 's') {
      state = state!.copyWith(textSize: state!.height * .4, textSizeType: 's');
    } else if(size == 'm') {
      state = state!.copyWith(textSize: state!.height * .6, textSizeType: 'm');
    } else if(size == 'l') {
      state = state!.copyWith(textSize: state!.height * .8, textSizeType: 'l');
    }
  }

  // 폰트 굵기 변경하기
  void setTextWeight(bool isBold) {
    state = state!.copyWith(isBold: isBold);
  }

  // 폰트 기울기 여부 변경하기
  void setTextItalic(bool isItalic) {
    state = state!.copyWith(isItalic: isItalic);
  }

  // 텍스트 내용 변경하기
  void setText(String text) {
    state = state!.copyWith(text: text);
  }

  // 번역하기
  Future<void> translate(String inputText, String fromLanguage, String toLanguage) async {
    try {
      var outputText = await _translator.translate(inputText, from: fromLanguage, to: toLanguage);
      print('outputText >>> $outputText');
      _translateResult = outputText.text;
    } catch (error) {
      print('error during TextEditController.translate >>> $error');
    }
  }

  // 녹음 시작하기
  void startRecord(String localeId) async {
    try {
      if(_sttInit) {
        _stt.listen(
          listenOptions: SpeechListenOptions(cancelOnError: true),
          localeId: localeId,
          onResult: (value) {
            print(value.recognizedWords);
            _recordResult = value.recognizedWords;
          }
        );
      }
    } catch (error) {
      print('error during TextEditController.startRecord >>> $error');
    }
  }

  // 녹음 끄기 (해당 내용을 가지고 번역 모달의 input으로 가져가기)
  void stopRecord() async {
    if(_sttInit) {
      await _stt.stop();
      print(_recordResult);
    }
  }

}