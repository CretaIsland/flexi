import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../components/text_button.dart';
import '../../../feature/content/controller/content_list_controller.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class ContentDeleteModal extends ConsumerWidget {
  const ContentDeleteModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final contentListController = ref.watch(contentListControllerProvider.notifier);
    
    return Container(
      width: .93.sw,
      height: .35.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .05.sh, right: .055.sw),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.circular(.025.sh)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Are you sure?', style: FlexiFont.semiBold24),
          SizedBox(height: .02.sh),
          Text('This will delete \nlocally stored content.', style: FlexiFont.regular16,),
          SizedBox(height: .03.sh),
          FlexiTextButton(
            width: .82.sw, 
            height: .06.sh, 
            text: 'Delete',
            fillColor: FlexiColor.secondary,
            onPressed: () {
              if(ref.watch(selectAllProvider)) {
                contentListController.deleteAllContents();
              } else {
                contentListController.deleteContents(ref.watch(selectContentsProvider));
              }
              ref.watch(selectModeProvider.notifier).state = false;
              ref.watch(selectAllProvider.notifier).state = false;
              ref.invalidate(selectContentsProvider);
              context.pop();
            },
          ),
          SizedBox(
            width: .82.sw,
            height: .06.sh,
            child: TextButton(
              onPressed: () => context.pop(),
              child: Text('Cancel', style: FlexiFont.regular16),
            ),
          )
        ],
      ),
    );
  }

}