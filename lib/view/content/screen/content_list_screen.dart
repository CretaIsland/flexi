import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../components/search_bar.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';
import '../modal/content_delete_modal.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);
final selectContentsProvider = StateProvider<List<int>>((ref) => List.empty());


class ContentListScreen extends ConsumerWidget {
  const ContentListScreen({super.key, required this.rootContext});
  final BuildContext rootContext;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(selectModeProvider.notifier).state = false;
        ref.watch(selectAllProvider.notifier).state = false;
        ref.invalidate(selectContentsProvider);
      },
      child: Container(
        color: FlexiColor.backgroundColor,
        padding: EdgeInsets.only(left: .055.sw, top: .065.sh, right: .055.sw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Contents', style: FlexiFont.semiBold30),
                InkWell(
                  onTap: () {
                    if(ref.watch(selectModeProvider)) {
                      showModalBottomSheet(
                        context: rootContext,
                        backgroundColor: Colors.transparent, 
                        builder: (context) => const ContentDeleteModal()
                      );
                    } else {
                      // 새로 생성하고
                      context.go('/content/info');
                    }
                  },
                  child: Container(
                    width: .04.sh,
                    height: .04.sh,
                    decoration: BoxDecoration(
                      color: ref.watch(selectModeProvider) ? FlexiColor.secondary : FlexiColor.primary,
                      borderRadius: BorderRadius.circular(.02.sh)
                    ),
                    child: Center(
                      child: Icon(
                        ref.watch(selectModeProvider) ? Icons.delete_outline : Icons.add,
                        color: Colors.white, 
                        size: .03.sh
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: .02.sh),
            FlexiSearchBar(
              hintText: 'Search your content',
              onChanged: (value) {},
            ),
            SizedBox(height: .025.sh),
            Visibility(
              visible: ref.watch(selectModeProvider),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Select All', style: FlexiFont.regular12),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      ref.watch(selectAllProvider.notifier).state = !ref.watch(selectAllProvider);
                    },
                    child: ref.watch(selectAllProvider) ? 
                      Icon(Icons.check_circle, color: FlexiColor.secondary, size: .025.sh) :
                      Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                  )
                ],
              )
            ),
            SizedBox(height: .015.sh),
            Expanded(
              child: contentListView(),
            )
          ],
        ),
      ),
    );
  }

  Consumer contentListView() {
    return Consumer(
      builder: (context, ref, child) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () => ref.watch(selectModeProvider.notifier).state = true,
              onTap: () {
                if(ref.watch(selectModeProvider)) {

                } else {
                  context.go('/content/info');
                }
              },
              child: Container(
                width: .38.sw,
                height: .13.sh,
                padding: EdgeInsets.all(.015.sh),
                margin: EdgeInsets.only(bottom: .02.sh),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(.01.sh)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Content name', style: FlexiFont.regular14),
                        Visibility(
                          visible: ref.watch(selectModeProvider),
                          child: ref.watch(selectContentsProvider).contains(index) ?
                            Icon(Icons.check_circle, color: FlexiColor.secondary, size: .025.sh) :
                            Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                        )
                      ]
                    ),
                    Container(
                      width: .82.sw,
                      height: .07.sh,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(.01.sh)
                      ),
                    )
                  ],
                ),
              )
            );
          },
        );
      },
    );
  }

}