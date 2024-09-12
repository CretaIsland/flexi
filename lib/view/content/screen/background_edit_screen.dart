import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../core/controller/local_storage_controller.dart';
import '../../../feature/content/controller/content_edit_controller.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/utils.dart';
import '../component/background_edit_preview.dart';



class BackgroundEditScreen extends StatefulWidget {
  const BackgroundEditScreen({super.key});

  @override
  State<BackgroundEditScreen> createState() => _BackgroundEditScreenState();
}

class _BackgroundEditScreenState extends State<BackgroundEditScreen> {

  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              var content = ref.watch(contentEditControllerProvider);
              return Container(
                height: .6.sh,
                color: FlexiColor.stringToColor(content.backgroundColor),
                child: Column(
                  children: [
                    Container(
                      height: .275.sh,
                      color: Colors.black.withOpacity(.6),
                      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              ref.watch(contentInfoControllerProvider.notifier).setContent(content);
                              context.go('/content/info');
                            }, 
                            icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: Colors.white)
                          ),
                          TextButton(
                            onPressed: () => ref.watch(contentEditControllerProvider.notifier).undo(), 
                            child: Text('Reset', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white))
                          )
                        ]
                      )
                    ),
                    BackgroundEditPreview(content: content),
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(.6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => setState(() => _tabIndex = 0), 
                              child: Text('Asset', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: _tabIndex == 0 ? Colors.white : FlexiColor.grey[600]))
                            ),
                            TextButton(
                              onPressed: () => setState(() => _tabIndex = 1), 
                              child: Text('Palette', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: _tabIndex == 1 ? Colors.white : FlexiColor.grey[600]))
                            ),
                            TextButton(
                              onPressed: () => setState(() => _tabIndex = 2), 
                              child: Text('Gallery', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: _tabIndex == 2 ? Colors.white : FlexiColor.grey[600]))
                            )
                          ]
                        )
                      )
                    )
                  ]
                )
              );
            }
          ),
          Container(
            width: 1.sw,
            height: .4.sh,
            color: FlexiColor.backgroundColor,
            child: _tabIndex == 0 ? Container() : _tabIndex == 1 ? colorPalette() : galleryContent()
          )
        ]
      )
    );
  }

  Widget colorPalette() {
    List<Color> colors = const [
      Color(0xffFFFFFF), Color(0xffD7D7D7), Color(0xff959595), Color(0xff747474), Color(0xff4D4D4D), Color(0xff000000),
      Color(0xffF42626), Color(0xffFD6969), Color(0xffFFB3B3), Color(0xffF76631), Color(0xffFC9874), Color(0xffFFC8B4),
      Color(0xffF38C2D), Color(0xffFFB470), Color(0xffFFD2A9), Color(0xffE89B29), Color(0xffFEBE5D), Color(0xffFED593),
      Color(0xffA6A435), Color(0xffC8C661), Color(0xffE2E2A4), Color(0xff53A840), Color(0xff81BD73), Color(0xffB4DBAC),
      Color(0xff5AC4C1), Color(0xff90DCDC), Color(0xffC1EBEA), Color(0xff5878B3), Color(0xff93AAD6), Color(0xffC3CEE2),
      Color(0xff7356A6), Color(0xffA08BC6), Color(0xffC5BDD5), Color(0xffAB419B), Color(0xffCB86BF), Color(0xffE2BDDE),
      Color(0xffFF768B), Color(0xffFFBCC5), Color(0xffFFDDE2), Color(0xffB16C57), Color(0xffCF9684), Color(0xffECC7BC),
    ];

    return Consumer(
      builder: (context, ref, child) => GridView.builder(
        padding: EdgeInsets.only(left: .045.sw, top: .025.sh, right: .045.sw),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          childAspectRatio: 22/17,
          mainAxisSpacing: 8,
          crossAxisSpacing: 12
        ), 
        itemCount: colors.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => ref.watch(contentEditControllerProvider.notifier).setBackgroundColor(colors[index]),
          child: Container(
            decoration: BoxDecoration(
              color: colors[index],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(.01.sh)
            )
          )
        )
      )
    );
  }

  Widget galleryContent() {
    return Consumer(
      builder: (context, ref, child) {
        var files = ref.watch(localStorageControllerProvider);

        return NotificationListener<ScrollEndNotification>(
          onNotification: (notification) {
            if(notification.metrics.pixels == notification.metrics.maxScrollExtent) {
              ref.watch(localStorageControllerProvider.notifier).loadNext();
            }
            return true;
          },
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: files.length,
            itemBuilder: (context, index) => FutureBuilder(
              future: files[index].thumbnailData, 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.data == null) return const SizedBox.shrink();
                  return GestureDetector(
                    onTap: () async {
                      var selectFile = await files[index].loadFile();
                      if(selectFile != null) {
                        ref.watch(contentEditControllerProvider.notifier).setBackgroundContent(
                          files[index].type.name, 
                          selectFile.path,
                          selectFile.path.split('/').last, 
                          snapshot.data!
                        );
                      } else {
                        FlexiUtils.showMsg('Error during load file');
                      }
                    },
                    child: Container(
                      width: 1.sw,
                      height: .06.sh,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: Image.memory(snapshot.data!).image, fit: BoxFit.cover),
                        border: const Border(bottom: BorderSide(color: Colors.white))
                      ),
                      child: files[index].type == AssetType.video ?
                        Center(child: Icon(Icons.play_arrow_rounded, size: .03.sh, color: Colors.white)) : 
                        const SizedBox.shrink()
                    )
                  );
                } else {
                  return SizedBox(
                    width: 1.sw,
                    height: .06.sh
                  );
                }
              }
            )
          )
        );
      }
    );
  }

}