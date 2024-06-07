import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/content/controller/text_edit_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';


final List<Map<String, String>> languages = [
  {'name': 'English', 'localeId': 'en_US', 'code': 'en'},
  {'name': '한국어', 'localeId': 'ko_KR', 'code': 'ko'},
  {'name': '日本語', 'localeId': 'ja_JP', 'code': 'ja'},
  {'name': 'French', 'localeId': 'fr_FR', 'code': 'fr'},
  {'name': 'Spanish', 'localeId': 'es_ES', 'code': 'es'},
];


class InputLanguageListBar extends ConsumerWidget {
  const InputLanguageListBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            for(var currentLanguage in ref.watch(currentInputLanguagesControllerProvider))
              InkWell(
                onTap: () => ref.watch(selectInputLanguageProvider.notifier).state = currentLanguage,
                child: Container(
                  width: .24.sw,
                  height: .04.sh,
                  margin: const EdgeInsets.only(right: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: ref.watch(selectInputLanguageProvider)['code'] == currentLanguage['code'] ? Border.all(color: FlexiColor.primary) : null,
                    borderRadius: BorderRadius.circular(.005.sh)
                  ),
                  child: Center(
                    child: Text(
                      currentLanguage['name']!, 
                      style: ref.watch(selectInputLanguageProvider)['code'] == currentLanguage['code'] ?
                        FlexiFont.semiBold14.copyWith(color: FlexiColor.primary): FlexiFont.regular14
                      ),
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
                    ref.watch(selectInputLanguageProvider.notifier).state = language;
                    if(!ref.watch(currentInputLanguagesControllerProvider).contains(language)) {
                      ref.watch(currentInputLanguagesControllerProvider.notifier).updateCurrentLanguage(language);
                    }
                    print(ref.watch(selectInputLanguageProvider));
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


class OutputLanguageListBar extends ConsumerWidget {
  const OutputLanguageListBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            for(var currentLanguage in ref.watch(currentOutputLanguagesControllerProvider))
              InkWell(
                onTap: () {
                  ref.watch(selectOutputLanguageProvider.notifier).state = currentLanguage;
                  ref.watch(textTranslateControllerProvider.notifier).translate(
                    ref.watch(textEditControllerProvider).text, 
                    ref.watch(selectInputLanguageProvider)['code']!,
                    ref.watch(selectOutputLanguageProvider)['code']!
                  );
                },
                child: Container(
                  width: .24.sw,
                  height: .04.sh,
                  margin: const EdgeInsets.only(right: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: ref.watch(selectOutputLanguageProvider)['code'] == currentLanguage['code'] ?Border.all(color: FlexiColor.primary) : null,
                    borderRadius: BorderRadius.circular(.005.sh)
                  ),
                  child: Center(
                    child: Text(
                      currentLanguage['name']!, 
                      style: ref.watch(selectOutputLanguageProvider)['code'] == currentLanguage['code'] ?
                        FlexiFont.semiBold14.copyWith(color: FlexiColor.primary) : FlexiFont.regular14
                      ),
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
                    ref.watch(selectOutputLanguageProvider.notifier).state = language;
                    if(!ref.watch(currentOutputLanguagesControllerProvider).contains(language)) {
                      ref.watch(currentOutputLanguagesControllerProvider.notifier).updateCurrentLanguage(language);
                    }
                    ref.watch(textTranslateControllerProvider.notifier).translate(
                      ref.watch(textEditControllerProvider).text, 
                      ref.watch(selectInputLanguageProvider)['code']!,
                      ref.watch(selectOutputLanguageProvider)['code']!
                    );
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