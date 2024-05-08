import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';
import 'component/edit_content_preview.dart';



final selectedColor = StateProvider<Color>((ref) => Colors.white);
final selectedContentThumbnail = StateProvider<Uint8List?>((ref) => null);
File? selectedContent;


class EditBackgroundScreen extends ConsumerStatefulWidget {
  const EditBackgroundScreen({super.key});

  @override
  ConsumerState<EditBackgroundScreen> createState() => _EditBackgroundScreenState();
}

class _EditBackgroundScreenState extends ConsumerState<EditBackgroundScreen> {

  final tabIndex = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ref.watch(selectedColor),
        child: Column(
          children: [
            Container(
              height: screenHeight * .275,
              color: Colors.black.withOpacity(.6),
              padding: EdgeInsets.only(top: screenHeight * .04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.go("/content/detail"), 
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: screenHeight * .03)
                  ),
                  TextButton(
                    onPressed: () {
                      context.go("/content/detail");
                    }, 
                    child: Text("Apply", style: FlexiFont.regular16.copyWith(color: Colors.white))
                  )
                ],
              ),
            ),
            const EditContentPreview(),
            Expanded(
              child: Container(
                color: Colors.black.withOpacity(.6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => ref.watch(tabIndex.notifier).state = 0, 
                      child: Text("Asset", style: FlexiFont.regular16.copyWith(color: Colors.white))
                    ),
                    TextButton(
                      onPressed: () => ref.watch(tabIndex.notifier).state = 1, 
                      child: Text("Palette", style: FlexiFont.regular16.copyWith(color: Colors.white))
                    ),
                    TextButton(
                      onPressed: () => ref.watch(tabIndex.notifier).state = 2, 
                      child: Text("Gallery", style: FlexiFont.regular16.copyWith(color: Colors.white))
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * .42,
              color: FlexiColor.backgroundColor,
              child: ref.watch(tabIndex) == 0 ? const AssetContent() : ref.watch(tabIndex) == 1 ? const ColorPalette() : const GalleryContent(),
            )
          ],
        ),
      ),
    );
  }
}


// asset tab
class AssetContent extends ConsumerWidget {
  const AssetContent({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder:(context, index) {
        return InkWell(
          onTap: () { },
          child: Container(
            width: screenWidth,
            height: screenHeight * .06,
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              border: Border.all(color:  Colors.white)
            ),
          ),
        );
      },
    );
  }

}

// color palette tab
class ColorPalette extends ConsumerWidget {
  const ColorPalette({super.key});
  
  final List<Color> colors = const [
    Color(0xffFFFFFF), Color(0xffD7D7D7), Color(0xff959595), Color(0xff747474), Color(0xff4D4D4D), Color(0xff000000),
    Color(0xffF42626), Color(0xffFD6969), Color(0xffFFB3B3), Color(0xffF76631), Color(0xffFC9874), Color(0xffFFC8B4),
    Color(0xffF38C2D), Color(0xffFFB470), Color(0xffFFD2A9), Color(0xffE89B29), Color(0xffFEBE5D), Color(0xffFED593),
    Color(0xffA6A435), Color(0xffC8C661), Color(0xffE2E2A4), Color(0xff53A840), Color(0xff81BD73), Color(0xffB4DBAC),
    Color(0xff5AC4C1), Color(0xff90DCDC), Color(0xffC1EBEA), Color(0xff5878B3), Color(0xff93AAD6), Color(0xffC3CEE2),
    Color(0xff7356A6), Color(0xffA08BC6), Color(0xffC5BDD5), Color(0xffAB419B), Color(0xffCB86BF), Color(0xffE2BDDE),
    Color(0xffFF768B), Color(0xffFFBCC5), Color(0xffFFDDE2), Color(0xffB16C57), Color(0xffCF9684), Color(0xffECC7BC),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // 그리드 설정
        crossAxisCount: 6,
        childAspectRatio: 22 / 17,
        mainAxisSpacing: 8,
        crossAxisSpacing: 12,
      ),
      itemCount: colors.length,
      itemBuilder:(context, index) {
        return InkWell(
          onTap: () {
            ref.watch(selectedContentThumbnail.notifier).state = null;
            print(ref.watch(selectedContentThumbnail));
            ref.watch(selectedColor.notifier).state = colors[index];
          },
          child: Container(
            decoration: BoxDecoration(
              color: colors[index],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(screenHeight * .01)
            ),
          ),
        );
      },
    );
  }

}

// gallery tab
int galleryPageIndex = 0;
final galleryContents = StateProvider<List<AssetEntity>>((ref) => []);
class GalleryContent extends ConsumerStatefulWidget {
  const GalleryContent({super.key});

  @override
  ConsumerState<GalleryContent> createState() => _GalleryContentState();
}

class _GalleryContentState extends ConsumerState<GalleryContent> {

  final loadStateProvider = StateProvider<bool>((ref) => false);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(galleryPageIndex == 0) initLoad();
    });
  }

  Future<void> initLoad() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if(ps.isAuth) {
      ref.watch(loadStateProvider.notifier).state = true;
      ref.watch(galleryContents.notifier).state = await PhotoManager.getAssetListPaged(
        page: galleryPageIndex,
        pageCount: 20
      );
      galleryPageIndex = 1;
      ref.watch(loadStateProvider.notifier).state = false;
    }
  }

  Future<void> nextLoad() async {
    ref.watch(loadStateProvider.notifier).state = true;
    var loadAssets = await PhotoManager.getAssetListPaged(
      page: galleryPageIndex, 
      pageCount: 20
    );
    ref.watch(galleryContents.notifier).state.addAll(loadAssets);
    galleryPageIndex += 1;
    ref.watch(loadStateProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight * .4,
      color: ref.watch(loadStateProvider) ? Colors.black.withOpacity(.5) : Colors.transparent,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification && notification.metrics.pixels == notification.metrics.maxScrollExtent) {
            nextLoad();
          }
          return false;
        },
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: ref.watch(galleryContents).length,
          itemBuilder:(context, index) {
            return fileThumbnail(ref.watch(galleryContents)[index]);
          },
        ),
      ),
    );
  }

  Widget fileThumbnail(AssetEntity assetFile) {
    return Container(
      width: screenWidth,
      height: screenHeight * .06,
      margin: const EdgeInsets.only(bottom: 1),
      child: FutureBuilder(
        future: assetFile.thumbnailData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            var thumbnailBytes = snapshot.data;
            if(thumbnailBytes == null) {
              return Center(
                child: Text("error during load file", style: FlexiFont.regular14),
              );
            } else {
              return InkWell(
                onTap: () async {
                  selectedContent = await assetFile.file;
                  ref.watch(selectedContentThumbnail.notifier).state = thumbnailBytes;
                },
                child: Stack(
                  children: [
                    Positioned.fill(child: Image.memory(thumbnailBytes, fit: BoxFit.cover)),
                    assetFile.type == AssetType.video ? Center(child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: screenHeight * .03)) : const SizedBox.shrink()
                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text("error during load file", style: FlexiFont.regular14),
            );
          } else {
            return Center(
              child: SizedBox(
                width: screenHeight * .05,
                child: CircularProgressIndicator(color: FlexiColor.primary)
              ),
            );
          }
        },
      )
    );

  }

}
