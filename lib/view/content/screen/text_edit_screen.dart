import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/content/controller/content_edit_controller.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/current_language_controller.dart';
import '../../../feature/content/model/content_info.dart';
import '../../../utils/flexi_utils.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';
import '../component/language_list_bar.dart';
import '../component/text_edit_preview.dart';
import '../modal/text_translate_modal.dart';



final sttModeProvider = StateProvider<bool>((ref) => true);
final isSpeakingProvider = StateProvider<bool>((ref) => true);
final keyboardEventProvider = StateProvider<FocusNode>((ref) => FocusNode());


class TextEditScreen extends ConsumerStatefulWidget {
  const TextEditScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextEditScreenState();
}

class _TextEditScreenState extends ConsumerState<TextEditScreen> {

  List<Color> fontColors = const [
    Color(0xff000000), Color(0xffFFFFFF), Color(0xffE53935), 
    Color(0xffFFB74D), Color(0xffFFEE58), Color(0xff388E5A), 
    Color(0xff42A5F5), Color(0xff8756D5), Color(0xffEA9BD7)
  ];

  
  @override
  Widget build(BuildContext context) {

    final contentInfoController = ref.watch(contentInfoControllerProvider.notifier);
    final textEditController = ref.watch(contentEditControllerProvider.notifier);
    final sttController = ref.watch(sTTControllerProvider.notifier);

    ContentInfo backgroundInfo = ref.read(contentEditControllerProvider);
    ContentInfo textInfo = ref.watch(contentEditControllerProvider);


    return Scaffold(
      backgroundColor: FlexiUtils.stringToColor(backgroundInfo.backgroundColor),
      body: Column(
        children: [
          Container(
            width: 1.sw,
            height: .275.sh,
            padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
            color: Colors.black.withOpacity(.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        ref.watch(currentInputLanguagesControllerProvider.notifier).saveChange();
                        context.go('/content/info');
                      }, 
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: .03.sh),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.watch(currentInputLanguagesControllerProvider.notifier).saveChange();
                        contentInfoController.change(textInfo);
                        context.go('/content/info');
                      }, 
                      child: Text('Apply', style: FlexiFont.regular16.copyWith(color: Colors.white))
                    )
                  ],
                ),
                SizedBox(height: .045.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for(var color in fontColors)
                      InkWell(
                        onTap: () => textEditController.setTextColor(color),
                        child: Container(
                          width: .035.sh,
                          height: .035.sh,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: textInfo.textColor == color.toString() ? FlexiColor.primary : Colors.white),
                            borderRadius: BorderRadius.circular(.0175.sh)
                          ),
                        ),
                      )
                  ],
                ),
                SizedBox(height: .025.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        fontSizeButton('Small', 's', FlexiFont.regular9),
                        SizedBox(width: .02.sw),
                        fontSizeButton('Medium', 'm', FlexiFont.regular11),
                        SizedBox(width: .02.sw),
                        fontSizeButton('Large', 'l', FlexiFont.regular13)
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => textEditController.setTextWeight(!textInfo.bold),
                          child: Container(
                            width: .03.sh,
                            height: .03.sh,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: textInfo.bold ? Border.all(color: FlexiColor.primary, width: 2) : null, 
                              borderRadius: BorderRadius.circular(.005.sh)
                            ),
                            child: Center(
                              child: Icon(Icons.format_bold, color: textInfo.bold ? FlexiColor.primary : Colors.black, size: .02.sh)
                            ),
                          ),
                        ),
                        SizedBox(width: .02.sw),
                        InkWell(
                          onTap: () => textEditController.setTextItalic(!textInfo.italic),
                          child: Container(
                            width: .03.sh,
                            height: .03.sh,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: textInfo.italic ? Border.all(color: FlexiColor.primary, width: 2) : null, 
                              borderRadius: BorderRadius.circular(.005.sh)
                            ),
                            child: Center(
                              child: Icon(Icons.format_italic, color: textInfo.italic ? FlexiColor.primary : Colors.black, size: .02.sh)
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          // preview
          TextEditPreview(contentInfo: ref.watch(contentEditControllerProvider)),
          Expanded(
            child: Container(
              width: 1.sw,
              color: Colors.black.withOpacity(.6),
              padding: EdgeInsets.only(left: .055.sw, right: .055.sw, bottom: .02.sh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const TextTranslateModal(),
                      );
                    },
                    child: Container(
                      width: .05.sh,
                      height: .05.sh,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(.025.sh)
                      ),
                      child: Center(
                        child: Icon(Icons.g_translate_outlined, color: FlexiColor.primary, size: .025.sh),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if(ref.watch(sttModeProvider)) {
                        ref.watch(sttModeProvider.notifier).state = false;
                        ref.watch(keyboardEventProvider).requestFocus();
                      } else {
                        ref.watch(keyboardEventProvider).unfocus();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          ref.watch(sttModeProvider.notifier).state = true;
                        });
                      }
                    },
                    child: Container(
                      width: .05.sh,
                      height: .05.sh,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(.025.sh)
                      ),
                      child: Center(
                        child: Icon(
                          ref.watch(sttModeProvider) ? Icons.keyboard_outlined : Icons.mic_none, 
                          color: FlexiColor.primary, 
                          size: .025.sh
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
          Visibility(
            visible: ref.watch(sttModeProvider),
            child: Container(
              width: 1.sw,
              height: .42.sh,
              color: FlexiColor.backgroundColor,
              padding: EdgeInsets.only(left: .055.sw, top: .02.sh, right: .055.sw),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InputLanguageListBar(),
                      SizedBox(height: .04.sh),
                      SizedBox(
                        width: 1.sw,
                        height: .15.sh,
                        child: SingleChildScrollView(
                          child: Text(ref.watch(isSpeakingProvider) ? 'Speak your text' : 'Press and hold the button to record', style: FlexiFont.regular20),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onLongPressStart: (details) {
                      if(ref.watch(selectInputLanguageProvider)['localeId'] == null || ref.watch(selectInputLanguageProvider)['localeId']!.isEmpty) {
                        Fluttertoast.showToast(msg: 'select language');
                      } else {
                        ref.watch(isSpeakingProvider.notifier).state = true;
                        textEditController.setLanguage(ref.watch(selectInputLanguageProvider)['localeId']!.replaceAll("_", "-"));
                        sttController.startRecord(ref.watch(selectInputLanguageProvider)['localeId']!, (value) { if(value.isNotEmpty) textEditController.setText(value);});
                      }
                    },
                    onLongPressEnd: (details) {
                      ref.watch(isSpeakingProvider.notifier).state = false;
                      sttController.stopRecord();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: .15.sh),
                      child: Center(
                        child: Image.asset(ref.watch(isSpeakingProvider) ? 'assets/image/speaking.gif' : 'assets/image/speak.png'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  // font size button
  Widget fontSizeButton(String label, String value, TextStyle labelStyle) {
    final textEditController = ref.watch(contentEditControllerProvider.notifier);
    final textInfo = ref.watch(contentEditControllerProvider);

    return InkWell(
      onTap: () => textEditController.setTextSize(value),
      child: Container(
        width: .2.sw,
        height: .03.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          border: textInfo.textSizeType == value ? Border.all(color: FlexiColor.primary, width: 2) : null, 
          borderRadius: BorderRadius.circular(.005.sh)
        ),
        child: Center(
          child: Text(label, style: textInfo.textSizeType == value ? labelStyle.copyWith(color: FlexiColor.primary) : labelStyle)
        ),
      ),
    );
  }


}