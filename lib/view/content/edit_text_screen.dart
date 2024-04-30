import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/circle_icon_button.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'component/edit_content_preview.dart';
import 'component/language_list.dart';
import 'edit_background_screen.dart';
import 'modal/translate_text_modal.dart';



final selectedFontStyle = StateProvider<TextStyle?>((ref) => null);
final textContent = StateProvider<String>((ref) => "");


class EditTextScreen extends ConsumerStatefulWidget {
  const EditTextScreen({super.key});

  @override
  ConsumerState<EditTextScreen> createState() => _EditTextScreenState();
}

class _EditTextScreenState extends ConsumerState<EditTextScreen> {

  FocusNode focusNode = FocusNode();
  final isSTTMode = StateProvider<bool>((ref) => true);
  final isSpeaking = StateProvider<bool>((ref) => false);
  List<Color> fontColors = const [
    Color(0xff000000), Color(0xffFFFFFF), Color(0xffE53935), 
    Color(0xffFFB74D), Color(0xffFFEE58), Color(0xff388E5A), 
    Color(0xff42A5F5), Color(0xff8756D5), Color(0xffEA9BD7)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: ref.watch(selectedColor),
        child: Column(
          children: [
            Container(
              height: screenHeight * .275,
              color: Colors.black.withOpacity(.6),
              padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .04, right: screenWidth * .055),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => context.go("/content/info"), 
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: screenHeight * .025)
                      ),
                      TextButton(
                        onPressed: () {
                          context.go("/content/info");
                        }, 
                        child: Text("Apply", style: FlexiFont.regular16.copyWith(color: Colors.white))
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * .045),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for(int i = 0; i < fontColors.length; i++)
                        InkWell(
                          child: Container(
                            width: screenHeight * .03,
                            height: screenHeight * .03,
                            decoration: BoxDecoration(
                              color: fontColors[i],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(screenHeight * .015)
                            ),
                          ),
                        )
                    ],
                  ),
                  SizedBox(height: screenHeight * .025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          fontSizeButton("Small", FlexiFont.regular9),
                          fontSizeButton("Medium", FlexiFont.regular11),
                          fontSizeButton("Large", FlexiFont.regular13)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          fontStyleButton(Icons.format_bold_rounded),
                          fontStyleButton(Icons.format_italic_rounded)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Stack(
              children: [
                const EditContentPreview(),
                Opacity(
                  opacity: 0.0,
                  child: TextField(
                    focusNode: focusNode,
                    onTap: () {
                      ref.watch(isSTTMode.notifier).state = false;
                    },
                    onSubmitted: (value) {
                      Future.delayed(const Duration(seconds: 1)).then((value) {
                        ref.watch(isSTTMode.notifier).state = true;
                      }); 
                    },
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.black.withOpacity(.6),
                padding: EdgeInsets.only(left: screenWidth * .055, right: screenWidth * .055, bottom: screenHeight * .02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleIconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context, 
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return const TranslateTextModal();
                          },
                        );
                      },
                      size: screenHeight * .05, 
                      icon: Icon(Icons.g_translate_outlined, color: FlexiColor.primary),
                      fillColor: Colors.white,
                    ),
                    CircleIconButton(
                      onPressed: () {
                        ref.watch(isSTTMode.notifier).state = false;
                        focusNode.requestFocus();
                      },
                      size: screenHeight * .05, 
                      icon: Icon(Icons.keyboard_alt_outlined, color: FlexiColor.primary),
                      fillColor: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            ref.watch(isSTTMode) ? Container(
              width: screenWidth,
              height: screenHeight * .42,
              padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .04, right: screenWidth * .055),
              color: FlexiColor.screenColor,
              child: Stack(
                children: [
                  Column(
                    children: [
                      LanguageList(),
                      SizedBox(height: screenHeight * .04),
                      SizedBox(
                        width: screenWidth,
                        height: screenHeight * .07,
                        child: SingleChildScrollView(
                          child: Text(
                            "Speack your text . . .", 
                            style: FlexiFont.regular24.copyWith(color: FlexiColor.grey[500]))
                        )
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * .2),
                    child: Center(
                      child: InkWell(
                        onTapDown: (value) => ref.watch(isSpeaking.notifier).state = true,
                        onTapUp: (details) => ref.watch(isSpeaking.notifier).state = false,
                        child: Image.asset(ref.watch(isSpeaking) ? "assets/image/speaking.gif" : "assets/image/speak.png")
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

  Widget fontSizeButton(String btnLabel, TextStyle labelStyle) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: screenWidth * .2,
        height: screenHeight * .03,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          // border:  Border.all(color: FlexiColor.primary) : null,
          borderRadius: BorderRadius.circular(screenHeight * .005)
        ),
        child: Center(
          child: Text(btnLabel, style: labelStyle)
        ),
      ),
    );
  }

  Widget fontStyleButton(IconData btnIcon) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: screenWidth * .066,
        height: screenHeight * .03,
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          // border:  Border.all(color: FlexiColor.primary) : null,
          borderRadius: BorderRadius.circular(screenHeight * .005)
        ),
        child: Center(
          child: Icon(btnIcon, color: Colors.black, size: 14),
        ),
      ),
    );
  }

}

