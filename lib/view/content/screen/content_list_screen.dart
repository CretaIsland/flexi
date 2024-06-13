import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/content_list_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';
import '../component/content_preview.dart';
import '../modal/content_delete_modal.dart';



class ContentListScreen extends ConsumerStatefulWidget {
  const ContentListScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentListScreenState();
}

class _ContentListScreenState extends ConsumerState<ContentListScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(searchTextProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectMode = ref.watch(selectModeProvider);
    final selectAll = ref.watch(selectAllProvider);
    final selectContents = ref.watch(selectContentsProvider);
    final searchText = ref.watch(searchTextProvider);
    final contentListController = ref.watch(contentListControllerProvider.notifier);
    final contentInfoController = ref.watch(contentInfoControllerProvider.notifier);

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
                  onTap: () async {
                    if(selectMode) {
                      showModalBottomSheet(
                        context: widget.rootContext,
                        backgroundColor: Colors.transparent, 
                        builder: (context) => const ContentDeleteModal()
                      );
                    } else {
                      var newContent = await contentListController.createContent();
                      if(newContent != null) {
                        contentInfoController.setContent(newContent);
                        context.go('/content/info');
                      }
                    }
                  },
                  child: Container(
                    width: .04.sh,
                    height: .04.sh,
                    decoration: BoxDecoration(
                      color: selectMode ? FlexiColor.secondary : FlexiColor.primary,
                      borderRadius: BorderRadius.circular(.02.sh)
                    ),
                    child: Center(
                      child: Icon(
                        selectMode ? Icons.delete_outline : Icons.add,
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
              onChanged: (value) {
                ref.watch(searchTextProvider.notifier).state = value;
              },
            ),
            SizedBox(height: .025.sh),
            Visibility(
              visible: selectMode,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Select All', style: FlexiFont.regular12),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      ref.watch(selectAllProvider.notifier).state = !selectAll;
                    },
                    child: selectAll ? 
                      Icon(Icons.check_circle, color: FlexiColor.secondary, size: .025.sh) :
                      Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                  )
                ],
              )
            ),
            SizedBox(height: .015.sh),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return ref.watch(contentListControllerProvider).when(
                    data: (data) {
                      if(data.isEmpty) {
                        return Center(
                          child: Text('no contents!', style: FlexiFont.regular14),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return data[index].contentName.contains(searchText) ?  GestureDetector(
                            onLongPress: () => ref.watch(selectModeProvider.notifier).state = true,
                            onTap: () {
                              if(selectMode) {
                                if(selectContents.contains(data[index].contentId)) {
                                  selectContents.removeAt(index);
                                  ref.watch(selectContentsProvider.notifier).state = [...selectContents];
                                } else {
                                  ref.watch(selectContentsProvider.notifier).state = [...selectContents, data[index].contentId];
                                }
                              } else {
                                contentInfoController.setContent(data[index]);
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
                                      Text(data[index].contentName, style: FlexiFont.regular14),
                                      Visibility(
                                        visible: selectMode,
                                        child: selectContents.contains(data[index].contentId) || selectAll ?
                                          Icon(Icons.check_circle, color: FlexiColor.secondary, size: .025.sh) :
                                          Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                                      )
                                    ]
                                  ),
                                  ContentPreview(
                                    previewWidth: .82.sw, 
                                    previewHeight: .07.sh, 
                                    contentInfo: data[index]
                                  )
                                ],
                              ),
                            )
                          ) : const SizedBox.shrink();
                        },
                      );
                    }, 
                    error: (error, stackTrace) => Center(child: Text('error during get contents', style: FlexiFont.regular14)), 
                    loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary))
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}