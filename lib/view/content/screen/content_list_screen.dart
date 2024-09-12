import 'package:flexi/feature/content/controller/content_info_controller.dart';
import 'package:flexi/feature/content/controller/content_list_controller.dart';
import 'package:flexi/util/design/colors.dart';
import 'package:flexi/view/content/component/content_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../modal/content_delete_modal.dart';



class ContentListScreen extends ConsumerStatefulWidget {
  const ContentListScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentListScreenState();
}

class _ContentListScreenState extends ConsumerState<ContentListScreen> {

  String _searchText = '';
  bool _selectMode = false;
  bool _selectAll = false;

  @override
  Widget build(BuildContext context) {
    var selectContents = ref.watch(selectContentsProvider);
    return GestureDetector(
      onTap: () {
        if(_selectMode) {
          setState(() {
            _selectMode = false;
            _selectAll = false;
          });
          ref.invalidate(selectContentsProvider);
        }
      },
      child: Container(
        color: FlexiColor.backgroundColor,
        padding: EdgeInsets.only(left: .055.sw, top: .065.sh, right: .055.sw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Content', style: Theme.of(context).textTheme.displayLarge),
                GestureDetector(
                  onTap: () async {
                    if(_selectMode) {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: widget.rootContext, 
                        builder: (context) => ContentDeleteModal(deleteAll: _selectAll)
                      );
                    } else {
                      var newContent = await ref.watch(contentListControllerProvider.notifier).createContent();
                      if(newContent != null) {
                        ref.watch(contentInfoControllerProvider.notifier).setContent(newContent);
                        if(context.mounted) context.go('/content/info');
                      }
                    }
                  },
                  child: Container(
                    width: .04.sh,
                    height: .04.sh,
                    decoration: BoxDecoration(
                      color: _selectMode ? FlexiColor.secondary : FlexiColor.primary,
                      borderRadius: BorderRadius.circular(.02.sh)
                    ),
                    child: Icon(_selectMode ? Icons.delete_outline : Icons.add, size: .03.sh, color: Colors.white)
                  )
                )
              ]
            ),
            SizedBox(height: .02.sh),
            FlexiSearchBar(
              hintText: 'Search your content', 
              onChanged: (value) => setState(() => _searchText = value)
            ),
            SizedBox(height: .025.sh),
            Visibility(
              visible: _selectMode,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Select All', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: FlexiColor.grey[600])),
                  SizedBox(width: .01.sw),
                  GestureDetector(
                    onTap: () => setState(() => _selectAll = !_selectAll),
                    child: _selectAll ? Icon(Icons.check_circle, size: .025.sh, color: FlexiColor.secondary) :
                      Icon(Icons.check_circle_outline, size: .025.sh, color: FlexiColor.grey[600])
                  )
                ]
              )
            ),
            SizedBox(height: .015.sh),
            Expanded(
              child: ref.watch(contentListControllerProvider).when(
                data: (data) {
                  if(data.isEmpty) {
                    return Center(
                      child: Text(
                        'No content', 
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: FlexiColor.grey[600])
                      )
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: data.length,
                    itemBuilder: (context, index) => data[index].contentName.toLowerCase().contains(_searchText.toLowerCase()) ? GestureDetector(
                      onTap: () {
                        if(_selectMode) {
                          if(selectContents.contains(data[index].contentId)) {
                            selectContents.remove(data[index].contentId);
                            ref.watch(selectContentsProvider.notifier).state = [...selectContents];
                          } else {
                            ref.watch(selectContentsProvider.notifier).state = [...selectContents, data[index].contentId];
                          }
                        } else {
                          ref.watch(contentInfoControllerProvider.notifier).setContent(data[index]);
                          context.go('/content/info');
                        }
                      },
                      onLongPress: () {
                        if(!_selectMode) {
                          setState(() {
                            _selectMode = true;
                          });
                        }
                      },
                      child: Container(
                        width: .89.sw,
                        height: .15.sh,
                        padding: EdgeInsets.all(.015.sh),
                        margin: EdgeInsets.only(bottom: .02.sh),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(.01.sh)
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data[index].contentName, style: Theme.of(context).textTheme.bodySmall),
                                Visibility(
                                  visible: _selectMode,
                                  child: selectContents.contains(data[index].contentId) ?
                                    Icon(Icons.check_circle, size: .025.sh, color: FlexiColor.secondary) :
                                    Icon(Icons.check_circle_outline, size: .025.sh, color: FlexiColor.grey[600])
                                )
                              ]
                            ),
                            SizedBox(height: .01.sh),
                            ContentPreview(width: .82.sw, height: .07.sh, content: data[index])
                          ],
                        )
                      )
                    ) : const SizedBox.shrink()
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    'Error during load content', 
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(color: FlexiColor.grey[600])
                  )
                ), 
                loading: () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: .03.sh,
                      height: .03.sh,
                      child: CircularProgressIndicator(
                        color: FlexiColor.grey[600],
                        strokeWidth: 2.5
                      )
                    ),
                    SizedBox(height: .015.sh),
                    Text('Loading saved contents', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600]))
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}