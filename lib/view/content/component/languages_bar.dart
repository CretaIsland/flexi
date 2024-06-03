import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/content/controller/current_language_controller.dart';
import '../../../feature/content/controller/text_edit_controller.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class LanguagesBar extends ConsumerWidget {
  LanguagesBar({super.key, required this.type});
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
    if(type == 'input') {
      return inputLanguagesBar();
    }
    return outputLanguagesBar();
  }

  Consumer inputLanguagesBar() {
    return Consumer(
      builder: (context, ref, child) {

        final selectLanguage = ref.watch(selectInputLanguageProvider);
        final currentLanguages = ref.watch(inputLanguagesControllerProvider);
        final currentLanguageController = ref.watch(inputLanguagesControllerProvider.notifier);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: .75.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for(var language in currentLanguages)
                    InkWell(
                      onTap: () =>ref.watch(selectInputLanguageProvider.notifier).state = language,
                      child: Container(
                        width: .24.sw,
                        height: .04.sh,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: selectLanguage == language ? Border.all(color: FlexiColor.primary) : null,
                          borderRadius: BorderRadius.circular(.005.sh)
                        ),
                        child: Center(
                          child: Text(
                            language['name']!,
                            style: selectLanguage == language ? 
                              FlexiFont.semiBold14.copyWith(color: FlexiColor.primary) : FlexiFont.regular14,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: FlexiColor.grey[600]!),
                borderRadius: BorderRadius.circular(.01.sh),
              ),
              position: PopupMenuPosition.under,
              color: Colors.white,
              child: Container(
                width: .04.sh,
                height: .04.sh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(.005.sh)
                ),
                child: Center(
                  child: Icon(Icons.more_horiz_rounded, color: FlexiColor.grey[600])
                ),
              ),
              itemBuilder: (context) {
                List<PopupMenuItem<String>> menuItems = [];
                for(var language in languages) {
                  menuItems.add(
                    PopupMenuItem(
                      height: .04.sh,
                      value: language['code'],
                      child: Text(language['name']!, style: FlexiFont.regular14),
                      onTap: () {
                        if(currentLanguages.indexWhere((element) => element['code'] == language['code']) == -1) {
                          currentLanguageController.updateCurrentLanguage(language);
                        }
                        ref.watch(selectInputLanguageProvider.notifier).state = language;
                      },
                    )
                  );
                }
                return menuItems;
              },
            )
          ],
        );
      },
    );
  }

  Consumer outputLanguagesBar() {
    return Consumer(
      builder: (context, ref, child) {

        final selectLanguage = ref.watch(selectOutputLanguageProvider);
        final currentLanguages = ref.watch(outputLanguagesControllerProvider);
        final currentLanguageController = ref.watch(outputLanguagesControllerProvider.notifier);
        final textEditController = ref.watch(textEditControllerProvider.notifier);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: .75.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for(var language in currentLanguages)
                    InkWell(
                      onTap: () {
                        ref.watch(selectOutputLanguageProvider.notifier).state = language;
                        textEditController.translate(
                          ref.watch(textEditControllerProvider)!.text, 
                          ref.watch(selectInputLanguageProvider)['code']!, 
                          language['code']!
                        );
                      },
                      child: Container(
                        width: .24.sw,
                        height: .04.sh,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: selectLanguage == language ? Border.all(color: FlexiColor.primary) : null,
                          borderRadius: BorderRadius.circular(.005.sh)
                        ),
                        child: Center(
                          child: Text(
                            language['name']!,
                            style: selectLanguage == language ? 
                              FlexiFont.semiBold14.copyWith(color: FlexiColor.primary) : FlexiFont.regular14,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: FlexiColor.grey[600]!),
                borderRadius: BorderRadius.circular(.01.sh),
              ),
              position: PopupMenuPosition.under,
              color: Colors.white,
              child: Container(
                width: .04.sh,
                height: .04.sh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(.005.sh)
                ),
                child: Center(
                  child: Icon(Icons.more_horiz_rounded, color: FlexiColor.grey[600])
                ),
              ),
              itemBuilder: (context) {
                List<PopupMenuItem<String>> menuItems = [];
                for(var language in languages) {
                  menuItems.add(
                    PopupMenuItem(
                      height: .04.sh,
                      value: language['code'],
                      child: Text(language['name']!, style: FlexiFont.regular14),
                      onTap: () {
                        if(currentLanguages.indexWhere((element) => element['code'] == language['code']) == -1) {
                          currentLanguageController.updateCurrentLanguage(language);
                        }
                        ref.watch(selectOutputLanguageProvider.notifier).state = language;
                      },
                    )
                  );
                }
                return menuItems;
              },
            )
          ],
        );
      },
    );
  }

}