import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:translator/translator.dart';

import '../../../components/text_button.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';
import '../component/language_list_bar.dart';



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
  FocusNode focusNode = FocusNode();

  final sttModeProvider = StateProvider<bool>((ref) => true);
  final isSpeakingProvider = StateProvider<bool>((ref) => false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: Colors.grey, // 콘텐츠 배경 색,
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
                        onPressed: () => context.go('/content/info'),
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: .03.sh),
                      ),
                      TextButton(
                        onPressed: () {
                          // 변경된 값 저장
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
                          onTap: () {},
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
                          fontSizeButton('Small', FlexiFont.regular9, () {}),
                          SizedBox(width: .02.sw),
                          fontSizeButton('Medium', FlexiFont.regular11, () {}),
                          SizedBox(width: .02.sw),
                          fontSizeButton('Large', FlexiFont.regular13, () {}),
                        ],
                      ),
                      Row(
                        children: [
                          fontEffectButton(Icons.format_bold, () {}),
                          SizedBox(width: .02.sw),
                          fontEffectButton(Icons.format_italic, () {}),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            // preview
            Stack(

            ),
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
                          focusNode.requestFocus();
                        } else {
                          focusNode.unfocus();
                          ref.watch(sttModeProvider.notifier).state = true;
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
                      LanguageListBar(),
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
                    },
                    onLongPressEnd: (details) {
                      print("click end");
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