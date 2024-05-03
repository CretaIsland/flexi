import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../components/bottom_navigation_bar.dart';
import '../../components/circle_icon_button.dart';
import '../../components/search_bar.dart';
import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';
import 'component/content_preview.dart';
import 'modal/content_delete_modal.dart';



final selectedMode = StateProvider<bool>((ref) => false);
final isAllSelected = StateProvider<bool>((ref) => false);
final selectedContentIndexs = StateProvider<List<int>>((ref) => []);

class ContentListScreen extends ConsumerStatefulWidget {
  const ContentListScreen({super.key});

  @override
  ConsumerState<ContentListScreen> createState() => _ContentListScreenState();
}

class _ContentListScreenState extends ConsumerState<ContentListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          ref.watch(selectedMode.notifier).state = false;
          ref.watch(isAllSelected.notifier).state = false;
        },
        child: Container(
          color: FlexiColor.backgroundColor,
          padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .065, right: screenWidth * .055),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Contents", style: FlexiFont.semiBold30),
                  CircleIconButton(
                    size: screenHeight * .04, 
                    icon: Icon(ref.watch(selectedMode) ? Icons.link_off_outlined : Icons.add, color: Colors.white, size: screenHeight * .03),
                    fillColor: ref.watch(selectedMode) ? FlexiColor.secondary : FlexiColor.primary,
                    onPressed: () {
                      if(ref.watch(selectedMode)) {
                        showModalBottomSheet(
                          context: context, 
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder:(context) => const ContentDeleteModal()
                        ) ;
                      } else {
                        context.go("/content/detail");
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 12),
              const FlexiSearchBar(hintText: "Search your content"),
              const SizedBox(height: 20),
              ref.watch(selectedMode) ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Select all", style: FlexiFont.regular12),
                  const SizedBox(width: 4),
                  CircleIconButton(
                    size: screenHeight * .025, 
                    icon: Icon(
                      Icons.check, 
                      color: ref.watch(isAllSelected) ? Colors.white : FlexiColor.grey[600], 
                      size: screenHeight * .02
                    ),
                    fillColor: ref.watch(isAllSelected) ? FlexiColor.secondary : null,
                    border: ref.watch(isAllSelected) ? null : Border.all(color: FlexiColor.grey[600]!),
                    onPressed: () {
                      ref.watch(isAllSelected.notifier).state = !ref.watch(isAllSelected);
                    },
                  )
                ],
              ) : const SizedBox.shrink(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder:(context, index) {
                    return ContentComponent(index: index);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }

}

class ContentComponent extends ConsumerWidget {
  const ContentComponent({super.key, required this.index});
  final int index;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onLongPress: () => ref.watch(selectedMode.notifier).state = true,
      onTap: () {
        if(ref.watch(selectedMode)) {
          ref.watch(selectedContentIndexs.notifier).state.add(index);
          return;
        }
        context.go("/content/detail");
      },
      child: Container(
        width: screenWidth * .89,
        height: screenHeight * .15,
        padding: EdgeInsets.only(left: screenWidth * .03, top: screenHeight * .015, right: screenWidth * .03),
        margin: EdgeInsets.only(bottom: screenHeight * .02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Content Name", style: FlexiFont.regular14),
                Visibility(
                  visible: ref.watch(selectedMode),
                  child: Container(
                    width: screenHeight * .02,
                    height: screenHeight * .02,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: FlexiColor.grey[600]!),
                      borderRadius: BorderRadius.circular(screenHeight * .01)
                    ),
                    child: Center(
                      child: Icon(Icons.check_rounded, color: FlexiColor.grey[600], size: screenHeight * .015),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * .01),
            ContentPreview(width: screenWidth * .82, height: screenHeight * .07)
          ],
        )
      ),
    );
  }

}