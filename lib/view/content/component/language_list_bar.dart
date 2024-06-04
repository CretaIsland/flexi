import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/content/controller/text_edit_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class LanguageListBar extends ConsumerWidget {
  LanguageListBar({super.key, required this.type});
  final String type;
  
  final List<Map<String, String>> languages = [
    {'name': 'English', 'localeId': 'en_US', 'code': 'en'},
    {'name': '한국어', 'localeId': 'ko_KR', 'code': 'ko'},
    {'name': '日本語', 'localeId': 'ja_JP', 'code': 'ja'},
    {'name': 'French', 'localeId': 'fr_FR', 'code': 'fr'},
    {'name': 'Spanish', 'localeId': 'es_ES', 'code': 'es'},
  ];


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectLanguage = ref.watch(type == 'input' ? selectInputLanguageProvider : selectOutputLanguageProvider);
    final selectLanguageController = type == 'input' ? ref.watch(selectInputLanguageProvider.notifier) : ref.watch(selectOutputLanguageProvider.notifier);
    final currentLanguages = ref.watch(type == 'input' ? currentInputLanguagesControllerProvider : currentOutputLanguagesControllerProvider);


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            for(var currentLanguage in currentLanguages)
              InkWell(
                onTap: () async {
                  selectLanguageController.state = currentLanguage;
                  if(type == 'output') {
                    print('start');
                    print(ref.watch(selectInputLanguageProvider)['code']!);
                    print(selectLanguage['code']);
                    ref.watch(translateResultProvider.notifier).state = await ref.watch(textEditControllerProvider.notifier).translate(
                      ref.watch(textEditControllerProvider).text,
                      ref.watch(selectInputLanguageProvider)['code']!,
                      selectLanguage['code']!
                    );
                    print('end');
                  }
                },
                child: Container(
                  width: .24.sw,
                  height: .04.sh,
                  margin: const EdgeInsets.only(right: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: selectLanguage == currentLanguage ?Border.all(color: FlexiColor.primary) : null,
                    borderRadius: BorderRadius.circular(.005.sh)
                  ),
                  child: Center(
                    child: Text(currentLanguage['name']!, style: FlexiFont.regular14),
                  ),
                ),
              )
          ],
        ),
        PopupMenuButton(
          color: Colors.white,
          position: PopupMenuPosition.under,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: FlexiColor.grey[600]!),
            borderRadius: BorderRadius.circular(.01.sh)
          ),
          child: Container(
            width: .04.sh,
            height: .04.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.005.sh)
            ),
            child: Center(
              child: Icon(Icons.more_horiz_rounded, color: FlexiColor.grey[600]),
            ),
          ),
          itemBuilder: (context) {
            List<PopupMenuItem> items = [];
            for(var language in languages) {
              items.add(
                PopupMenuItem(
                  height: .04.sh,
                  value: language['code'],
                  child: Text(language['name']!, style: FlexiFont.regular14),
                  onTap: () async {
                    selectLanguageController.state = language;
                    if(type == 'input') {
                      ref.watch(currentInputLanguagesControllerProvider.notifier).updateCurrentLanguage(language);
                    } else {  
                      ref.watch(currentOutputLanguagesControllerProvider.notifier).updateCurrentLanguage(language);
                      if(type == 'output') {
                        print('start');
                        print(ref.watch(selectInputLanguageProvider)['code']!);
                        print(selectLanguage['code']);
                        ref.watch(translateResultProvider.notifier).state = await ref.watch(textEditControllerProvider.notifier).translate(
                          ref.watch(textEditControllerProvider).text,
                          ref.watch(selectInputLanguageProvider)['code']!,
                          selectLanguage['code']!
                        );
                        print('end');
                      }
                    }
                  },
                )
              );
            }
            return items;
          },
        )
      ],
    );
  }

}