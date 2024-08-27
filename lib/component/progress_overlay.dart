import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/design/colors.dart';



final totalTaskProvider = StateProvider((ref) => 0);
final completeTaskProvider = StateProvider((ref) => 0);

class ProgressOverlay extends ConsumerWidget {
  const ProgressOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: FlexiColor.grey[200]!.withOpacity(.8),
      body: SizedBox(
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: .075.sh,
              height: .075.sh,
              padding: EdgeInsets.all(.0125.sh),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.0125.sh)
              ),
              child: Image.asset('assets/image/wifi_loading.gif', fit: BoxFit.cover)
            ),
            SizedBox(height: .05.sh),
            SizedBox(
              width: .5.sw,
              child: LinearProgressIndicator(
                value: (1 / ref.read(totalTaskProvider)) * ref.watch(completeTaskProvider),
                valueColor: AlwaysStoppedAnimation<Color>(FlexiColor.primary),
                backgroundColor: FlexiColor.grey[400],
                borderRadius: BorderRadius.circular(.01.sh)
              )
            ),
            SizedBox(height: .03.sh),
            Text('${ref.watch(completeTaskProvider)}/${ref.read(totalTaskProvider)}', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: FlexiColor.primary))
          ]
        ),
      )
    );
  }
}