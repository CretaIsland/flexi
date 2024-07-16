import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class AppOptionScreen extends StatelessWidget {
  const AppOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.go('/settings'), 
                icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh)
              ),
              Text('App Setting', style: FlexiFont.semiBold20),
              SizedBox(width: .06.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('Device Scan Option', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          Container(
            width: .89.sw,
            height: .06.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  value: 'Hotspot',
                  items: [
                    DropdownMenuItem(
                      value: 'Hotspot',
                      child: Text('Hotspot', style: FlexiFont.regular14)
                    ),
                    DropdownMenuItem(
                      value: 'Bluetooth',
                      child: Text('Bluetooth', style: FlexiFont.regular14)
                    )
                  ],
                  onChanged: (value) {},
                  borderRadius: BorderRadius.circular(.01.sh),
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.keyboard_arrow_down, color: FlexiColor.grey[600])
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  
}