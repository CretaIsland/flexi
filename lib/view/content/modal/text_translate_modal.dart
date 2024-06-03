import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../components/text_button.dart';
import '../../../feature/content/controller/current_language_controller.dart';
import '../../../feature/content/controller/text_edit_controller.dart';
import '../../../utils/ui/colors.dart';
import '../component/languages_bar.dart';



class TextTranslateModal extends ConsumerStatefulWidget {
  const TextTranslateModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextTranslateModalState();
}

class _TextTranslateModalState extends ConsumerState<TextTranslateModal> {

  late TextEditingController _inputController;
  late TextEditingController _outputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
    _outputController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {

    final contentInfo = ref.watch(textEditControllerProvider);
    _inputController.text = contentInfo!.text;
    _outputController.text = ref.watch(textEditControllerProvider.notifier).translateResult();

    return Container(
      width: 1.sw,
      height: .9.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .075.sh, right: .055.sw),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(.055.sw), topRight: Radius.circular(.055.sw))
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            LanguagesBar(type: 'input'),
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
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(.02.sh),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none
                ),
                maxLines: null,
              ),
            ),
            SizedBox(height: .03.sh),
            Icon(Icons.arrow_drop_down, color: FlexiColor.primary, size: .05.sh),
            SizedBox(height: .03.sh),
            LanguagesBar(type: 'output'),
            SizedBox(height: .02.sh),
            Container(
              width: .89.sw,
              height: .225.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.01.sh)
              ),
              child: TextField(
                controller: _outputController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(.02.sh),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none
                ),
                maxLines: null,
              ),
            ),
            SizedBox(height: .05.sh),
            FlexiTextButton(
              width: .89.sw, 
              height: .06.sh, 
              text: 'Add',
              fillColor: FlexiColor.primary,
              onPressed: () async {
                ref.watch(textEditControllerProvider.notifier).setText(ref.watch(textEditControllerProvider.notifier).translateResult());          
                context.pop();
              },
            )
          ],
        ),
      ),
    );
  }
  
}