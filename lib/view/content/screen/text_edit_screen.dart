import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/current_language_controller.dart';
import '../../../feature/content/controller/text_edit_controller.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';
import '../component/languages_bar.dart';
import '../component/text_edit_preview.dart';
import '../modal/text_translate_modal.dart';



class TextEditScreen extends ConsumerStatefulWidget {
  const TextEditScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

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
    final contentInfo = ref.watch(textEditControllerProvider);
    final textEditController = ref.watch(textEditControllerProvider.notifier);


    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: FlexiColor.stringToColor(contentInfo!.backgroundColor), // 콘텐츠 배경 색,
        child: Column(
          children: [
            Container(
              height: .3.sh,
              color: Colors.black.withOpacity(.6),
              padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          ref.watch(inputLanguagesControllerProvider.notifier).saveChange();
                          ref.watch(outputLanguagesControllerProvider.notifier).saveChange();
                          context.go('/content/info');
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: .03.sh),
                      ),
                      TextButton(
                        onPressed: () {
                          // 변경된 값 저장
                          ref.watch(inputLanguagesControllerProvider.notifier).saveChange();
                          ref.watch(outputLanguagesControllerProvider.notifier).saveChange();
                          contentInfoController.change(contentInfo);
                          print(contentInfo.text);
                          context.go('/content/info');
                        }, 
                        child: Text('Apply', style: FlexiFont.regular16.copyWith(color: Colors.white))
                      )
                    ],
                  ),
                  SizedBox(height: .05.sh),
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
                              border: Border.all(color: Colors.white),
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
                          fontSizeButton('Small', FlexiFont.regular9, () => textEditController.setTextSize('s')),
                          SizedBox(width: .02.sw),
                          fontSizeButton('Medium', FlexiFont.regular11, () => textEditController.setTextSize('m')),
                          SizedBox(width: .02.sw),
                          fontSizeButton('Large', FlexiFont.regular13, () => textEditController.setTextSize('l')),
                        ],
                      ),
                      Row(
                        children: [
                          fontEffectButton(Icons.format_bold, () => textEditController.setTextWeight(!contentInfo.isBold)),
                          SizedBox(width: .02.sw),
                          fontEffectButton(Icons.format_italic, () => textEditController.setTextItalic(!contentInfo.isItalic)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            // preview
            TextEditPreview(contentInfo: contentInfo),
            Expanded(
              child: Container(
                color: Colors.black.withOpacity(.6),
                padding: EdgeInsets.only(left: .055.sw, right: .055.sw, bottom: .02.sh),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                             ref.watch(sttModeProvider) ? Icons.keyboard_alt_outlined : Icons.mic_none, 
                            color: FlexiColor.primary, 
                            size: .025.sh
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
            // record
            ref.watch(sttModeProvider) ? Container(
              height: .41.sh,
              color: FlexiColor.backgroundColor,
              padding: EdgeInsets.only(left: .055.sw, top: .02.sh, right: .055.sw),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LanguagesBar(type: 'input'),
                      SizedBox(height: .04.sh),
                      SizedBox(
                        width: 1.sw,
                        height: .07.sh,
                        child: SingleChildScrollView(
                          child: Text('Speack your text. . .', style: FlexiFont.regular24.copyWith(color: FlexiColor.grey[500])),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onLongPressStart: (details) {
                      print("click start");
                      ref.watch(isSpeakingProvider.notifier).state = true;
                      textEditController.startRecord(ref.watch(selectInputLanguageProvider)['localeId'] ?? 'en_US');
                    },
                    onLongPressEnd: (details) {
                      print("click end");
                      textEditController.stopRecord();
                      ref.watch(isSpeakingProvider.notifier).state = false;
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: .2.sh),
                      child: Center(
                        child: Image.asset(ref.watch(isSpeakingProvider) ? 'assets/image/speaking.gif' : 'assets/image/speak.png'),
                      ),
                    ),
                  )
                ],
              ),
            ) : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget fontSizeButton(String label, TextStyle labelStyle, void Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: .2.sw,
        height: .03.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(.005.sh)
        ),
        child: Center(
          child: Text(label, style: labelStyle,),
        ),
      ),
    );
  }

  Widget fontEffectButton(IconData icon, void Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: .03.sh,
        height: .03.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(.005.sh)
        ),
        child: Center(
          child: Icon(icon, color: Colors.black, size: .02.sh)
        ),
      ),
    );
  }

}