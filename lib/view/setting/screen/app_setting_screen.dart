import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/setting/controller/app_setting_controller.dart';
import '../../../util/ui/colors.dart';
import '../../../util/ui/fonts.dart';



class AppSettingScreen extends ConsumerWidget {
  const AppSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.go('/setting'), 
                icon: Icon(Icons.arrow_back_ios, size: .025.sh, color: FlexiColor.primary)
              ),
              Text('App Setting', style: FlexiFont.semiBold20),
              SizedBox(width: .05.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('Device Register Option', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          Container(
            width: .89.sw,
            height: .06.sh,
            padding: EdgeInsets.only(left: .035.sw, right: .035.sw),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                child: DropdownButton(
                  value: ref.watch(appSettingControllerProvider)['registerOption'],
                  items:['Hotspot', 'Bluetooth'].map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value)
                    );
                  }).toList(),
                  onChanged: (value) => ref.watch(appSettingControllerProvider.notifier).setRegisterType(value.toString()),
                  style: FlexiFont.regular16,
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(.01.sh),
                  icon: Icon(Icons.keyboard_arrow_down, size: .03.sh, color: FlexiColor.grey[600]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}