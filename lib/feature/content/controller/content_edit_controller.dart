import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import '../model/content_model.dart';
import 'content_info_controller.dart';

part 'content_edit_controller.g.dart';



@riverpod 
class ContentEditController extends _$ContentEditController {

  late ContentModel _original;

  @override
  ContentModel build() {
    ref.onDispose(() {
      print('ContentEditController Dispose');
    });
    print('ContentEditController Build');
    _original = ref.read(contentInfoControllerProvider);
    return ref.read(contentInfoControllerProvider);
  }

  void undo() {
    state = _original;
  }

  // Edit Background
  void setBackgroundColor(Color color) {
    state = state.copyWith(
      backgroundType: 'color',
      backgroundColor: color.value.toString(),
      filePath: '',
      fileName: '',
      fileThumbnail: ''
    );
  }

  void setBackgroundContent(String contentType, String contentPath, String contentName, Uint8List contentThumbnail) {
    state = state.copyWith(
      backgroundType: contentType,
      filePath: contentPath,
      fileName: contentName,
      fileThumbnail: base64Encode(contentThumbnail),
      backgroundColor: '4282532418'
    );
  }

  // Edit Background
  void setText(String text) {
    state = state.copyWith(text: text);
  }

  void setLanguage(String localeId) {
    state = state.copyWith(language: localeId);
  }

  void setTextColor(Color color) {
    state = state.copyWith(textColor: color.value.toString());
  }

  void setTextSize(int size) {
    state = state.copyWith(textSize: size);
  }

  void setTextWeight(bool isBold) {
    state = state.copyWith(bold: isBold);
  }

  void setTextItalic(bool isItalic) {
    state = state.copyWith(italic: isItalic);
  }

}

@riverpod 
class STTController extends _$STTController {

  late SpeechToText _stt;
  bool _sttInit = false;

  @override
  String build() {
    ref.onDispose(() {
      print('STTController Dispose!!!');
    });
    print('STTController Build!!!');
    _stt = SpeechToText();
    _stt.initialize().then((value) {
      _sttInit = value;
    });
    return '';
  }

  void startRecord(String localeId, void Function(String value) onRecord) async {
    try {
      if(_sttInit) {
        _stt.listen(
          listenOptions: SpeechListenOptions(cancelOnError: true),
          localeId: localeId,
          onResult: (value) => onRecord(value.recognizedWords)
        );
      }
    } catch (error) {
      print('Error at TextEditController.startRecord >>> $error');
    }
  }

  void stopRecord() async {
    if(_sttInit) {
      await _stt.stop();
    }
  }

}

@riverpod
class TranslateController extends _$TranslateController {

  late GoogleTranslator _translator;

  @override
  void build() {
    ref.onDispose(() {
      print('TranslateController Dispose!!!');
    });
    print('TranslateController Build!!!');
    _translator = GoogleTranslator();
  }

  // 번역하기
  Future<String?> translate({required String inputText, String from = 'auto', required String to}) async {
    try {
      var outputText = await _translator.translate(
        inputText,
        from: from, 
        to: to
      );
      return outputText.text;
    } catch (error) {
      print('Error at TextEditController.translate >>> ${error.toString()}');
      return null;
    }
  }

}