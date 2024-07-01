import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/text_button.dart';
import '../../../component/text_field.dart';
import '../../../feature/auth/controller/auth_service.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

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
              Text('Account Detail', style: FlexiFont.semiBold20),
              SizedBox(width: .06.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('User Name', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            controller: TextEditingController(text: currentUser!.nickname),
            textStyle: FlexiFont.regular14
          ),
          SizedBox(height: .015.sh),
          Text('Email', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            controller: TextEditingController(text: currentUser!.email),
            textStyle: FlexiFont.regular14
          ),
          SizedBox(height: .015.sh),
          Text('Enterprise', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            controller: TextEditingController(text: currentUser!.enterprise),
            textStyle: FlexiFont.regular14
          ),
          SizedBox(height: .35.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh, 
            text: 'Logout',
            backgroundColor: Colors.white,
            textColor: FlexiColor.secondary,
            onPressed: () async {
              AuthController authController = AuthController();
              authController.initialize();
              await authController.logout();
              context.go('/');
            },
          )
        ],
      ),
    );
  }

}