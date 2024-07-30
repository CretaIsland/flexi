import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../util/ui/colors.dart';
import '../../../util/ui/fonts.dart';



final totalTaskProvider = StateProvider<int>((ref) => 0);
final completedTaskProvider = StateProvider<int>((ref) => 0);

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var totalTask = ref.read(totalTaskProvider);
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
                value: (1 / totalTask) * ref.watch(completedTaskProvider),
                minHeight: .01.sh,
                backgroundColor: FlexiColor.grey[400],
                valueColor: AlwaysStoppedAnimation<Color>(FlexiColor.primary),
                borderRadius: BorderRadius.circular(.01.sh)
              ),
            ),
            SizedBox(height: .03.sh),
            Text(
              '${ref.watch(completedTaskProvider)}/$totalTask',
              style: FlexiFont.semiBold14.copyWith(color: FlexiColor.primary)
            )
          ],
        ),
      ),
    );
  }
  
}