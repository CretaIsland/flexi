import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/content_list_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/design/fonts.dart';
import '../../../component/search_bar.dart';
import '../component/content_preview.dart';
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
                Text('Contents', style: FlexiFont.semiBold30),
                InkWell(
                  onTap: () {
                    if(_selectMode) {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: widget.rootContext, 
                        builder: (context) => ContentDeleteModal(deleteAll: _selectAll),
                      );
                    } else {
                      ref.watch(contentListControllerProvider.notifier).createContent().then((value) {
                        if(value != null) {
                          ref.watch(contentInfoControllerProvider.notifier).setContent(value);
                          context.go('/content/info');
                        }
                      });
                    }
                  },
                  child: Container(
                    width: .04.sh,
                    height: .04.sh,
                    decoration: BoxDecoration(
                      color: _selectMode ? FlexiColor.secondary : FlexiColor.primary,
                      borderRadius: BorderRadius.circular(.02.sh)
                    ),
                    child: Icon(_selectMode ? Icons.delete_outline : Icons.add, size: .03.sh, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(height: .02.sh),
            FlexiSearchBar(
              hintText: 'Search your content',
              onChanged: (value) => setState(() {
                _searchText = value;
              }),
            ),
            SizedBox(height: .025.sh),
            Visibility(
              visible: _selectMode,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Select All', style: FlexiFont.regular12),
                  SizedBox(width: .015.sw),
                  InkWell(
                    onTap: () => setState(() {
                      _selectAll = !_selectAll;
                    }),
                    child: _selectAll ? Icon(Icons.check_circle, size: .025.sh, color: FlexiColor.secondary) :
                      Icon(Icons.check_circle_outline, size: .025.sh, color: FlexiColor.grey[600])
                  )
                ],
              )
            ),
            SizedBox(height: .01.sh),
            Expanded(
              child: ref.watch(contentListControllerProvider).when(
                data: (data) {
                  if(data.isEmpty) {
                    return Center(
                      child: Text('No content', style: FlexiFont.regular14),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: data.length,
                    itemBuilder: (context, index) => data[index].contentName.contains(_searchText) ? GestureDetector(
                      onTap: () {
                        if(_selectMode) {
                          if(ref.watch(selectContentsProvider).contains(data[index].contentId)) {
                            ref.watch(selectContentsProvider).remove(data[index].contentId);
                            ref.watch(selectContentsProvider.notifier).state = [...ref.watch(selectContentsProvider)];
                          } else {
                            ref.watch(selectContentsProvider.notifier).state = [...ref.watch(selectContentsProvider), data[index].contentId];
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
                                Text(data[index].contentName, style: FlexiFont.regular14),
                                Visibility(
                                  visible: _selectMode,
                                  child: ref.watch(selectContentsProvider).contains(data[index].contentId) || _selectAll ? 
                                    Icon(Icons.check_circle, size: .025.sh, color: FlexiColor.secondary) :
                                    Icon(Icons.check_circle_outline, size: .025.sh, color: FlexiColor.grey[600])
                                )
                              ],
                            ),
                            SizedBox(height: .01.sh),
                            ContentPreview(.82.sw, .07.sh, data[index])
                          ],
                        ),
                      ),
                    ) : const SizedBox.shrink(),
                  );
                }, 
                error: (error, stackTrace) => Center(child: Text('error during get contents',style: FlexiFont.regular14)), 
                loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary))
              ),
            )
          ],
        ),
      ),
    );
  }
}