import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../feature/content/controller/current_language_controller.dart';
import '../../../util/design/colors.dart';



// localeId: stt 및 tts
// code: translate
final List<Map<String, String>> languages = [
  {'name': 'English', 'localeId': 'en_US', 'code': 'en'},
  {'name': '한국어', 'localeId': 'ko_KR', 'code': 'ko'},
  {'name': '日本語', 'localeId': 'ja_JP', 'code': 'ja'},
  {'name': '中文', 'localeId': 'cmn_CN', 'code': 'zh-cn'},
  {'name': 'French', 'localeId': 'fr_FR', 'code': 'fr'},
  {'name': 'Spanish', 'localeId': 'es_ES', 'code': 'es'},
];

class InputLanguageListBar extends ConsumerWidget {
  const InputLanguageListBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, String>> currentLanguages = ref.watch(currentInputLanguagesControllerProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for(var language in currentLanguages)
              GestureDetector(
                onTap: () => ref.watch(selectInputLanguageProvider.notifier).state = language,
                child: Container(
                  width: .24.sw,
                  height: .04.sh,
                  margin: EdgeInsets.only(right: .015.sw),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: ref.watch(selectInputLanguageProvider) == language ? Border.all(color: FlexiColor.primary) : null,
                    borderRadius: BorderRadius.circular(.005.sh)
                  ),
                  child: Center(
                    child: Text(
                      language['name']!, 
                      style: ref.watch(selectInputLanguageProvider) == language ?
                        Theme.of(context).textTheme.bodySmall!.copyWith(color: FlexiColor.primary) : 
                        Theme.of(context).textTheme.bodySmall
                    )
                  )
                )
              )
          ]
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
              child: Icon(Icons.more_horiz_rounded, color: FlexiColor.grey[600])
            )
          ),
          itemBuilder: (context) => languages.map((language) => PopupMenuItem(
            height: .04.sh,
            value: language['code'],
            child: Text(
              language['name']!,
              style: Theme.of(context).textTheme.bodySmall
            ),
            onTap: () async {
              ref.watch(selectInputLanguageProvider.notifier).state = language;
              if(!currentLanguages.contains(language)) {
                ref.watch(currentInputLanguagesControllerProvider.notifier).updateCurrentLanguage(language);
                ref.watch(currentInputLanguagesControllerProvider.notifier).saveChange();
              }
            }
          )).toList()
        )
      ]
    );
  }
} 

class OutputLanguageListBar extends ConsumerWidget {
  const OutputLanguageListBar({super.key, required this.onSelected});
  final void Function() onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, String>> currentLanguages = ref.watch(currentOutputLanguagesControllerProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for(var language in currentLanguages)
              GestureDetector(
                onTap: () {
                  ref.watch(selectOutputLanguageProvider.notifier).state = language;
                  onSelected();
                },
                child: Container(
                  width: .24.sw,
                  height: .04.sh,
                  margin: EdgeInsets.only(right: .015.sw),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: ref.watch(selectOutputLanguageProvider) == language ? Border.all(color: FlexiColor.primary) : null,
                    borderRadius: BorderRadius.circular(.005.sh)
                  ),
                  child: Center(
                    child: Text(
                      language['name']!, 
                      style: ref.watch(selectOutputLanguageProvider) == language ?
                        Theme.of(context).textTheme.bodySmall!.copyWith(color: FlexiColor.primary) : 
                        Theme.of(context).textTheme.bodySmall
                    )
                  )
                )
              )
          ]
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
              child: Icon(Icons.more_horiz_rounded, color: FlexiColor.grey[600])
            )
          ),
          itemBuilder: (context) => languages.map((language) => PopupMenuItem(
            height: .04.sh,
            value: language['code'],
            child: Text(
              language['name']!,
              style: Theme.of(context).textTheme.bodySmall
            ),
            onTap: () async {
              ref.watch(selectOutputLanguageProvider.notifier).state = language;
              if(!currentLanguages.contains(language)) {
                ref.watch(currentOutputLanguagesControllerProvider.notifier).updateCurrentLanguage(language);
                ref.watch(currentOutputLanguagesControllerProvider.notifier).saveChange();
              }
              // translate
              onSelected();
            }
          )).toList()
        )
      ]
    );
  }
} 