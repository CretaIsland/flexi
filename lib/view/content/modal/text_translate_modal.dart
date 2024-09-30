import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../component/text_button.dart';
import '../../../feature/content/controller/content_edit_controller.dart';
import '../../../feature/content/controller/current_language_controller.dart';
import '../../../util/design/colors.dart';
import '../component/language_list_bar.dart';



class TextTranslateModal extends ConsumerStatefulWidget {
  const TextTranslateModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextTranslateModalState();
}

class _TextTranslateModalState extends ConsumerState<TextTranslateModal> {

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  bool _executingTranslate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inputController.text = ref.watch(contentEditControllerProvider).text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _inputController.dispose();
    _outputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: .9.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .075.sh, right: .055.sw),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(.055.sw), topRight: Radius.circular(.055.sw))
      ),
      child: Column(
        children: [
          const InputLanguageListBar(),
          SizedBox(height: .02.sh),
          Container(
            width: .89.sw,
            height: .225.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: TextField(
              controller: _inputController,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(decorationThickness: 0),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(.02.sh),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none
              ),
              onChanged: (value) => ref.watch(contentEditControllerProvider.notifier).setText(value)
            )
          ),
          SizedBox(height: .03.sh),
          Icon(Icons.arrow_drop_down, color: FlexiColor.primary, size: .05.sh),
          SizedBox(height: .03.sh),
          OutputLanguageListBar(onSelected: () async {
            setState(() => _executingTranslate = true);
            var result = await ref.watch(translateControllerProvider.notifier).translate(
              inputText: _inputController.text,
              from: ref.watch(selectInputLanguageProvider)['code'] == null ? 'auto' : ref.watch(selectInputLanguageProvider)['code']!,
              to: ref.watch(selectOutputLanguageProvider)['code']!
            );
            setState(() => _executingTranslate = false);
            if(result != null) _outputController.text = result;
          }),
          SizedBox(height: .02.sh),
          Container(
            width: .89.sw,
            height: .225.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: _executingTranslate ? Center(
              child: SizedBox(
                width: .03.sh,
                height: .03.sh,
                child: CircularProgressIndicator(
                  color: FlexiColor.primary,
                  strokeWidth: 2.5
                )
              )
            ) : TextField(
              controller: _outputController,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(decorationThickness: 0),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(.02.sh),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none
              ),
              onChanged: (value) => ref.watch(contentEditControllerProvider.notifier).setText(value)
            )
          ),
          SizedBox(height: .05.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh, 
            text: 'Add',
            backgroundColor: FlexiColor.primary,
            onPressed: () async {
              ref.watch(contentEditControllerProvider.notifier).setLanguage(ref.watch(selectOutputLanguageProvider)['localeId']!.replaceAll('_', '-'));
              ref.watch(contentEditControllerProvider.notifier).setText(_outputController.text);
              context.pop();
            }
          )
        ]
      )
    );
  }
}