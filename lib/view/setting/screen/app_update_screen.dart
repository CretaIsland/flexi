import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../util/design/colors.dart';
import '../../../util/design/fonts.dart';
import '../../../component/text_button.dart';
import '../../../component/text_field.dart';



class AppUpdateScreen extends StatefulWidget {
  const AppUpdateScreen({super.key});

  @override
  State<AppUpdateScreen> createState() => _AppUpdateScreenState();
}

class _AppUpdateScreenState extends State<AppUpdateScreen> {

  final TextEditingController _versionController=  TextEditingController();

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
                onPressed: () => context.go('/setting'), 
                icon: Icon(Icons.arrow_back_ios, size: .025.sh, color: FlexiColor.primary)
              ),
              Text('App Update', style: FlexiFont.semiBold20),
              SizedBox(width: .05.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('App Version', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _versionController,
            textStyle: FlexiFont.regular16,
            readOnly: true
          ),
          SizedBox(height: .02.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh, 
            text: 'Check For Updates',
            backgroundColor: FlexiColor.primary
          )
        ],
      ),
    );
  }

}