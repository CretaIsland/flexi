import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class BackgroundEditScreen extends ConsumerWidget {
  BackgroundEditScreen({super.key});
  final tabIndexProvider = StateProvider<int>((ref) => 0);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: Colors.grey, // 콘텐츠 배경 색,
        child: Column(
          children: [
            Container(
              height: .275.sh,
              color: Colors.black.withOpacity(.6),
              padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => context.go('/content/info'),
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: .03.sh),
                      ),
                      TextButton(
                        onPressed: () {
                          // 변경된 값 저장
                          context.go('/content/info');
                        }, 
                        child: Text('Apply', style: FlexiFont.regular16.copyWith(color: Colors.white))
                      )
                    ],
                  ),
                  SizedBox(height: .05.sh),
                ],
              ),
            ),
            // preview
            SizedBox(
              width: 1.sw,
              height: .15.sh
            ),
            Expanded(
              child: Container(
                color: Colors.black.withOpacity(.6),
                padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => ref.watch(tabIndexProvider.notifier).state = 0, 
                      child: Text('Asset', style: FlexiFont.regular16.copyWith(color: ref.watch(tabIndexProvider) == 0 ? Colors.white : FlexiColor.grey[600]))
                    ),
                    TextButton(
                      onPressed: () => ref.watch(tabIndexProvider.notifier).state = 1, 
                      child: Text('Palette', style: FlexiFont.regular16.copyWith(color: ref.watch(tabIndexProvider) == 1 ? Colors.white : FlexiColor.grey[600]))
                    ),
                    TextButton(
                      onPressed: () => ref.watch(tabIndexProvider.notifier).state = 2, 
                      child: Text('Gallery', style: FlexiFont.regular16.copyWith(color: ref.watch(tabIndexProvider) == 2 ? Colors.white : FlexiColor.grey[600]))
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 1.sw,
              height: .42.sh,
              color: FlexiColor.backgroundColor,
              child: ref.watch(tabIndexProvider) == 0 ? assetContent() : ref.watch(tabIndexProvider) == 1 ? colorPalette() : galleryContent(),
            )
          ],
        ),
      ),
    );
  }

  Widget assetContent() {
    List<String> assetContents = const [];

    return Consumer(
      builder: (context, ref, child) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: assetContents.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () { },
              child: Container(
                width: 1.sw,
                height: .06.sw,
                margin: const EdgeInsets.only(bottom: 1),
                child: Image(
                  image: AssetImage(assetContents[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Consumer colorPalette() {
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
      builder: (context, ref, child) {
        return GridView.builder(
          padding: EdgeInsets.only(left: .045.sw, top: .025.sh, right: .045.sw),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            childAspectRatio: 22/17,
            mainAxisSpacing: 8,
            crossAxisSpacing: 12
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () { },
              child: Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(.01.sh)
                ),
              ),
            );
          },
        );
      },
    );

  }

  Consumer galleryContent() {
    return Consumer(
      builder: (context, ref, child) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 20,
          itemBuilder: (context, index) {
            Container(
              width: 1.sw,
              height: .06.sh,
              color: Colors.green.shade100,
              margin: const EdgeInsets.only(bottom: 2),
            );
          },
        );
      },
    );
  }

}