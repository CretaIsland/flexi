import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../components/text_button.dart';
import '../../../components/text_field.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {


  late TextEditingController _versionController;


  @override
  void initState() {
    super.initState();
    _versionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _versionController.dispose();
  }


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
              Text('App Update', style: FlexiFont.semiBold20),
              SizedBox(width: .06.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('App version', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _versionController,
            textStyle: FlexiFont.regular14
          ),
          SizedBox(height: .02.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh,
            fillColor: FlexiColor.primary, 
            text: 'Check For Updates',
            onPressed: () {
              // 앱스토어로 이동
            },
          )
        ],
      ),
    );
  }
  
}