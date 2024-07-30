import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/content/controller/content_list_controller.dart';
import '../../../util/ui/colors.dart';
import '../../../util/ui/fonts.dart';
import '../../common/component/text_button.dart';



class ContentDeleteModal extends ConsumerWidget {
  const ContentDeleteModal({super.key, required this.deleteAll});
  final bool deleteAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: .93.sw,
      height: .35.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw, bottom: .03.sh),
      margin: EdgeInsets.only(bottom: .02.sh),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.circular(.025.sh)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Are you sure?', style: FlexiFont.semiBold24),
          Text('This will delete \nlocally stored content.', style: FlexiFont.regular16),
          FlexiTextButton(
            width: .82.sw,
            height: .06.sh,
            text: 'Delete',
            backgroundColor: FlexiColor.secondary,
            onPressed: () {
              delete(ref).then((value) {
                ref.invalidate(selectContentsProvider);
                context.pop();
              });
            }
          ),
          SizedBox(
            width: .82.sw,
            height: .06.sh,
            child: TextButton(
              child: Text('Cancle', style: FlexiFont.regular16),
              onPressed: () => context.pop(),
            ),
          )
        ],
      ),
    );
  }

  Future<void> delete(WidgetRef ref) async {
    if(deleteAll) {
      await ref.watch(contentListControllerProvider.notifier).deleteAllContent();
    } else {
      await ref.watch(contentListControllerProvider.notifier).deleteContent(ref.watch(selectContentsProvider));
    }
  }

}