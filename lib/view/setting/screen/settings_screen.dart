import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .065.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Setting', style: FlexiFont.semiBold30),
          SizedBox(height: .05.sh),
          menuButton('Account', '/settings/account', context),
          SizedBox(height: .03.sh),
          menuButton('Device Recovery', '/settings/deviceRecovery', context),
          SizedBox(height: .03.sh),
          menuButton('App Update', '/settings/app', context),
        ],
      ),
    );
  }

  Widget menuButton(String label, String routePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(routePath);
      },
      child: Container(
        width: .89.sw,
        height: .06.sh,
        padding: EdgeInsets.only(left: .055.sw, right: .055.sw),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: FlexiColor.grey[400]!),
          borderRadius: BorderRadius.circular(.01.sh)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: FlexiFont.regular14),
            Icon(Icons.arrow_forward_ios, color: FlexiColor.grey[400], size: .03.sh)
          ],
        ),
      ),
    );
  }

}