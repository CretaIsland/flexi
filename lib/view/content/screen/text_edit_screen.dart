import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../feature/content/controller/content_edit_controller.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/current_language_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/utils.dart';
import '../component/language_list_bar.dart';
import '../component/text_edit_preview.dart';
import '../modal/text_translate_modal.dart';



final sttModeProvider = StateProvider<bool>((ref) => true);
final enableKeyboardProvider = StateProvider<FocusNode>((ref) => FocusNode());

class TextEditScreen extends ConsumerStatefulWidget {
  const TextEditScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextEditScreenState();
}

class _TextEditScreenState extends ConsumerState<TextEditScreen> {

  final List<Color> textColorList = const [
    Color(0xff000000), Color(0xffFFFFFF), Color(0xffE53935), 
    Color(0xffFFB74D), Color(0xffFFEE58), Color(0xff388E5A), 
    Color(0xff42A5F5), Color(0xff8756D5), Color(0xffEA9BD7)
  ];
  bool _isSpeaking = false;

  @override
  Widget build(BuildContext context) {
    var content = ref.watch(contentEditControllerProvider);
    return Scaffold(
      backgroundColor: FlexiColor.stringToColor(ref.read(contentEditControllerProvider).backgroundColor),
      body: Column(
        children: [
          Container(
            height: .275.sh,
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
                        ref.watch(contentInfoControllerProvider.notifier).setContent(content);
                        context.go('/content/detail');
                      }, 
                      icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: Colors.white)
                    ),
                    TextButton(
                      onPressed: () => ref.watch(contentEditControllerProvider.notifier).undo(), 
                      child: Text('Undo', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white))
                    )
                  ]
                ),
                SizedBox(height: .045.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for(var color in textColorList)
                      GestureDetector(
                        onTap: () => ref.watch(contentEditControllerProvider.notifier).setTextColor(color),
                        child: Container(
                          width: .035.sh,
                          height: .035.sh,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: content.textColor == color.value.toString() ? FlexiColor.primary : Colors.white),
                            borderRadius: BorderRadius.circular(.0175.sh)
                          )
                        )
                      )
                  ]
                ),
                SizedBox(height: .025.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        textSizeButton('Small', 18, Theme.of(context).textTheme.labelSmall!),
                        SizedBox(width: .02.sw),
                        textSizeButton('Medium', 22, Theme.of(context).textTheme.labelSmall!),
                        SizedBox(width: .02.sw),
                        textSizeButton('Large', 28, Theme.of(context).textTheme.labelSmall!),
                        SizedBox(width: .02.sw)
                      ]
                    ),
                    Row(
                      children: [
                        textEffectButton(Icons.format_bold, content.bold, () => ref.watch(contentEditControllerProvider.notifier).setTextWeight(!content.bold)),
                        SizedBox(width: .02.sw),
                        textEffectButton(Icons.format_italic, content.italic, () => ref.watch(contentEditControllerProvider.notifier).setTextItalic(!content.italic)),
                      ]
                    )
                  ]
                )
              ]
            )
          ),
          TextEditPreview(content: ref.read(contentEditControllerProvider)),
          Expanded(
            child: Container(
              color: Colors.black.withOpacity(.6),
              padding: EdgeInsets.only(left: .055.sw, right: .055.sw, bottom: .02.sh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => const TextTranslateModal()
                    ),
                    child: Container(
                      width: .05.sh,
                      height: .05.sh,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(.025.sh)
                      ),
                      child: Center(
                        child: Icon(Icons.g_translate_outlined, size: .025.sh, color: FlexiColor.primary)
                      )
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      if(ref.watch(sttModeProvider)) {
                        ref.watch(sttModeProvider.notifier).state = false;
                        ref.watch(enableKeyboardProvider).requestFocus();
                      } else {
                        ref.watch(enableKeyboardProvider).unfocus();
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
                        child: Icon(ref.watch(sttModeProvider) ? Icons.keyboard_outlined : Icons.mic_none, size: .025.sh, color: FlexiColor.primary)
                      )
                    )
                  )
                ]
              )
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
                        height: .15.sh,
                        child: SingleChildScrollView(
                          child: Text(_isSpeaking ? content.text.isEmpty ? 'Speak your text' : content.text : 'Press and hold the button to record',
                            style: Theme.of(context).textTheme.bodyLarge
                          )
                        )
                      )
                    ]
                  ),
                  GestureDetector(
                    onLongPressStart: (details) {
                      if(ref.watch(selectInputLanguageProvider)['localeId'] == null) {
                        FlexiUtils.showAlertMsg('Please select language');
                      } else {
                        setState(() => _isSpeaking = true);
                        ref.watch(contentEditControllerProvider.notifier).setLanguage(ref.watch(selectInputLanguageProvider)['localeId']!.replaceAll('_', '-'));
                        ref.watch(sTTControllerProvider.notifier).startRecord(ref.watch(selectInputLanguageProvider)['localeId']!, (value) {
                          if(value.isNotEmpty) ref.watch(contentEditControllerProvider.notifier).setText(value);
                        });
                      }
                    },
                    onLongPressEnd: (details) {
                      ref.watch(sTTControllerProvider.notifier).stopRecord();
                      setState(() => _isSpeaking = false);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: .15.sh),
                      child: Center(
                        child: Image.asset(_isSpeaking ? 'assets/image/speaking.gif' : 'assets/image/speak.png'),
                      )
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }

  Widget textSizeButton(String text, int size, TextStyle textStyle) {
    return GestureDetector(
      onTap: () => ref.watch(contentEditControllerProvider.notifier).setTextSize(size),
      child: Container(
        width: .2.sw,
        height: .03.sh,
        decoration: BoxDecoration(
          color: ref.watch(contentEditControllerProvider).textSize == size ? FlexiColor.primary : Colors.white,
          borderRadius: BorderRadius.circular(.005.sh)
        ),
        child: Center(
          child: Text(text, style: ref.watch(contentEditControllerProvider).textSize == size 
            ? textStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
            : textStyle
          )
        )
      )
    );
  }

  Widget textEffectButton(IconData icon, bool enableEffect, void Function()? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: .03.sh,
        height: .03.sh,
        decoration: BoxDecoration(
          color: enableEffect ? FlexiColor.primary : Colors.white,
          borderRadius: BorderRadius.circular(.005.sh)
        ),
        child: Center(
          child: Icon(icon, size: .02.sh, color: enableEffect ? Colors.white : FlexiColor.primary)
        )
      )
    );
  }

}