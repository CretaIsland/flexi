import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../core/controller/local_storage_controller.dart';
import '../../../feature/content/controller/content_edit_controller.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../util/design/colors.dart';
import '../component/background_edit_preview.dart';



class BackgroundEditScreen extends ConsumerStatefulWidget {
  const BackgroundEditScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BackgroundEditScreenState();
}

class _BackgroundEditScreenState extends ConsumerState<BackgroundEditScreen> {

  List<AssetPathEntity> _albumList = [AssetPathEntity(id: 'allFiles', name: 'Gallery')];
  AssetPathEntity _selectAlbum = AssetPathEntity(id: 'allFiles', name: 'Gallery');
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var permission = await PhotoManager.requestPermissionExtend();
      if(permission.isAuth) {
        var albums = await PhotoManager.getAssetPathList();
        setState(() {
          _albumList = [..._albumList, ...albums];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var content = ref.watch(contentEditControllerProvider);
    return Scaffold(
      backgroundColor: FlexiColor.stringToColor(content.backgroundColor),
      body: Column(
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
                    context.go('/content/detail');
                  }, 
                  icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: Colors.white)
                ),
                TextButton(
                  onPressed: () => ref.watch(contentEditControllerProvider.notifier).undo(), 
                  child: Text('Undo', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white))
                )
              ]
            )
          ),
          const BackgroundEditPreview(),
          Container(
            width: 1.sw,
            color: Colors.black.withOpacity(.6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => setState(() => _tabIndex = 0), 
                  child: Text('Asset', style: _tabIndex == 0 ? Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.grey[600])
                  )
                ),
                TextButton(
                  onPressed: () => setState(() => _tabIndex = 1), 
                  child: Text('Palette', style: _tabIndex == 1 ? Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.grey[600])
                  )
                ),
                IntrinsicWidth(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      child: DropdownButton(
                        value: _selectAlbum,
                        items: _albumList.map((album) {
                          return DropdownMenuItem(
                            value: album,
                            child: SizedBox(
                              width: .75.sw,
                              child: Text(
                                album.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis
                              )
                            )
                          );
                        }).toList(),
                        selectedItemBuilder: (context) => _albumList.map((album) {
                          return Container(
                            padding: EdgeInsets.only(left: .025.sw),
                            alignment: Alignment.centerLeft,
                            width: _selectAlbum.name.length * .03.sw > .5.sw ? .5.sw : _selectAlbum.name.length * .03.sw,
                            child: Text(
                              album.name, 
                              style: _tabIndex == 2 ? Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
                                : Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.grey[600]),
                              overflow: TextOverflow.ellipsis,
                            )
                          );
                        }).toList(),
                        menuWidth: .75.sw,
                        menuMaxHeight: .5.sh,
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(.01.sh),
                        onTap: () {
                          if(_tabIndex != 2) {
                            setState(() {
                              _tabIndex = 2;
                            });
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _selectAlbum = value!;
                          });
                        }
                      )
                    )
                  )
                )
              ]
            )
          ),
          Expanded(
            child: Container(
              width: 1.sw,
              color: FlexiColor.backgroundColor,
              child: _tabIndex == 0 ? assetContent() : _tabIndex == 1 ? colorPalette() : galleryContent()
            )
          )
        ]
      )
    );
  }

  Widget assetContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.construction, size: .1.sh, color: FlexiColor.grey[600]),
        SizedBox(height: .015.sh),
        Text('This feature is currently under development', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600]))
      ]
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
        var files = ref.watch(galleryControllerProvider(_selectAlbum));
        var galleryController = ref.watch(galleryControllerProvider(_selectAlbum).notifier);

        return NotificationListener<ScrollEndNotification>(
          onNotification: (notification) {
            if(notification.metrics.pixels == notification.metrics.maxScrollExtent) {
              galleryController.loadNext();
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