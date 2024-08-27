import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../util/design/colors.dart';
import '../../../util/design/fonts.dart';



class SettingMenuScreen extends StatelessWidget {
  const SettingMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .065.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Setting', style: FlexiFont.semiBold30),
          SizedBox(height: .05.sh),
          menuButton(context, 'Account', '/setting/account'),
          SizedBox(height: .03.sh),
          menuButton(context, 'App Setting', '/setting/appSetting'),
          SizedBox(height: .03.sh),
          menuButton(context, 'App Update', '/setting/appUpdate'),
          SizedBox(height: .03.sh),
          menuButton(context, 'Device Recovery', '/setting/deviceRecovery'),
        ]
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
          borderRadius: BorderRadius.circular(.01.sh)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: FlexiFont.regular14),
            Icon(Icons.arrow_forward_ios, size: .03.sh, color: FlexiColor.grey[400])
          ]
        ),
      ),
    );
  }

}