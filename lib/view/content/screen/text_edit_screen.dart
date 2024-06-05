import 'package:flexi/utils/ui/color.dart';
import 'package:flexi/view/content/component/language_list_bar.dart';
import 'package:flexi/view/content/component/text_edit_preview.dart';
import 'package:flexi/view/content/modal/text_translate_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/text_edit_controller.dart';
import '../../../utils/ui/font.dart';


class TextEditScreen extends ConsumerStatefulWidget {
  const TextEditScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextEditScreenState();
}

class _TextEditScreenState extends ConsumerState<TextEditScreen> {

  late TextEditingController recordTextController;
  List<Color> fontColors = const [
    Color(0xff000000), Color(0xffFFFFFF), Color(0xffE53935), 
    Color(0xffFFB74D), Color(0xffFFEE58), Color(0xff388E5A), 
    Color(0xff42A5F5), Color(0xff8756D5), Color(0xffEA9BD7)
  ];


  @override
  void initState() {
    super.initState();
    recordTextController = TextEditingController(text: 'Speak your text . . .');
  }


  @override
  Widget build(BuildContext context) {

    final sttMode = ref.watch(sttModeProvider);
    final isSpeaking = ref.watch(isSpeakingProvider);
    final contentInfo = ref.watch(textEditControllerProvider);
    final textEditController = ref.watch(textEditControllerProvider.notifier);
    final sttController = ref.watch(speechToTextControllerProvider.notifier);
    

    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: FlexiColor.stringToColor(contentInfo.backgroundColor),
        child: Column(
          children: [
            Container(
              height: .3.sh,
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
                          ref.watch(currentOutputLanguagesControllerProvider.notifier).saveChange();
                          context.go('/content/info');
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: .03.sh),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.watch(currentInputLanguagesControllerProvider.notifier).saveChange();
                          ref.watch(currentOutputLanguagesControllerProvider.notifier).saveChange();
                          ref.watch(contentInfoControllerProvider.notifier).change(contentInfo);
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
                          fontEffectButton(Icons.format_bold, () => textEditController.setTextWeight(!contentInfo.bold)),
                          SizedBox(width: .02.sw),
                          fontEffectButton(Icons.format_italic, () => textEditController.setTextItalic(!contentInfo.italic)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
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
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent, 
                        builder: (context) => const TextTranslateModal(),
                      ),
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
                        if(sttMode) {
                          ref.watch(sttModeProvider.notifier).state = false;
                          ref.watch(keyboardEventProvider).requestFocus();
                        } else {
                          ref.watch(keyboardEventProvider).unfocus();
                          Future.delayed(const Duration(milliseconds: 100), () {
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
                            sttMode ? Icons.keyboard_alt_outlined : Icons.mic_none, 
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
              visible: sttMode,
              child: Container(
                height: .41.sh,
                color: FlexiColor.backgroundColor,
                padding: EdgeInsets.only(left: .055.sw, top: .02.sh, right: .055.sw),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const InputLanguageListBar(),
                        SizedBox(height: .04.sh),
                        SizedBox(
                          width: 1.sw,
                          height: .07.sh,
                          child: SingleChildScrollView(
                            child: TextField(
                              controller: recordTextController,
                              maxLines: null,
                              readOnly: true,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none
                              ),
                              style: isSpeaking ? FlexiFont.regular24 : FlexiFont.regular24.copyWith(color: FlexiColor.grey[500])
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onLongPressStart: (details) {
                        ref.watch(isSpeakingProvider.notifier).state = true;
                        sttController.startRecord(ref.watch(selectInputLanguageProvider)['localeId']!);
                      },
                      onLongPressEnd: (details) {
                        sttController.stopRecord();
                        textEditController.setText(ref.watch(speechToTextControllerProvider));
                        ref.watch(isSpeakingProvider.notifier).state = false;
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: .2.sh),
                        child: Center(
                          child: Image.asset(isSpeaking ? 'assets/image/speaking.gif' : 'assets/image/speak.png'),
                        ),
                      ),
                    )
                  ],
                ),
              )
            )
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