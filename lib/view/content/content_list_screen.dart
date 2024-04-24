import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/bottom_navigation_bar.dart';
import '../../component/circle_icon_button.dart';
import '../../component/search_bar.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'modal/content_delete_modal.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final isAllSelectProvider = StateProvider<bool>((ref) => false);


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
          if(ref.watch(selectModeProvider)) {
            ref.watch(selectModeProvider.notifier).state = false;
            ref.watch(isAllSelectProvider.notifier).state = false;
          }
        },
        child: Container(
          color: FlexiColor.screenColor,
          padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .065, right: screenWidth * .055),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Contents", style: FlexiFont.semiBold30),
                  CircleIconButton(
                    onPressed: () {
                      if(ref.watch(selectModeProvider)) {
                        showModalBottomSheet(
                          context: context, 
                          backgroundColor: Colors.transparent,
                          builder:(context) => const ContentDeleteModal()
                        );
                      } else {
                        context.go("/content/info");
                      }
                    },
                    icon: Icon(ref.watch(selectModeProvider) ? Icons.delete_outline_rounded : Icons.add_rounded, color: Colors.white, size: screenHeight * .025),
                    size: screenHeight * .04,
                    fillColor: ref.watch(selectModeProvider) ? FlexiColor.secondary : FlexiColor.primary,
                  )
                ],
              ),
              SizedBox(height: screenHeight * .015),
              FlexiSearchBar(hintText: "Search your content", textEditingController: TextEditingController()),
              SizedBox(height: screenHeight * .025),
              Visibility(
                visible: ref.watch(selectModeProvider),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Select all', style: FlexiFont.regular12),
                    SizedBox(width: screenWidth * .01),
                    CircleIconButton(
                      onPressed: () => ref.watch(isAllSelectProvider.notifier).state = !ref.watch(isAllSelectProvider), 
                      icon: Icon(Icons.check_rounded, color: ref.watch(isAllSelectProvider) ? Colors.white : FlexiColor.grey[600], size: screenHeight * .015),
                      fillColor: ref.watch(isAllSelectProvider) ? FlexiColor.secondary : null,
                      border: ref.watch(isAllSelectProvider) ? null : Border.all(color: FlexiColor.grey[600]!),
                      size: screenHeight * .02,
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight * .01),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ContentComponent(index: index);
                  },
                ),
              )
            ],
          )
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
      onTap: () => ref.watch(selectModeProvider) ? null : context.go("/content/info"),
      onLongPress: () => ref.watch(selectModeProvider) ? null : ref.watch(selectModeProvider.notifier).state = true,
      child: Container(
        width: screenWidth * .89,
        height: screenHeight * .13,
        padding: EdgeInsets.only(left: screenHeight * .015, top: screenHeight * .015, right: screenHeight * .015),
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
                  visible: ref.watch(selectModeProvider),
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
            Container(
              width: screenWidth * .82,
              height: screenHeight * .07,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(screenHeight * .005)
              ),
              child: const Center(child: Text("Sample Text")),
            )
          ],
        ),
      ),
    );
  }

}