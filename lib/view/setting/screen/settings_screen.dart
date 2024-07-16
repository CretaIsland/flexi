import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



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
          menuButton(context, 'Account', '/settings/account'),
          SizedBox(height: .03.sh),
          menuButton(context, 'App Update', '/settings/app/info'),
          SizedBox(height: .03.sh),
          menuButton(context, 'App Setting', '/settings/app/option'),
          SizedBox(height: .03.sh),
          menuButton(context, 'Device Recovery', '/settings/deviceRecovery')
        ],
      ),
    );
  }

  Widget menuButton(BuildContext context, String text, String routePath) {
    return InkWell(
      onTap: () => context.go(routePath),
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
            Text(text, style: FlexiFont.regular14),
            Icon(Icons.arrow_forward_ios, color: FlexiColor.grey[400], size: .03.sh)
          ],
        ),
      )
    );
  }

}