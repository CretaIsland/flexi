import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/text_button.dart';
import '../../../component/text_field.dart';
import '../../../feature/auth/controller/account_controller.dart';
import '../../../main.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class AccountInfoScreen extends ConsumerStatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends ConsumerState<AccountInfoScreen> {

  late TextEditingController _roleController;
  late TextEditingController _accountNameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;


  @override
  void initState() {
    super.initState();
    _roleController = TextEditingController();
    _accountNameController = TextEditingController();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _roleController.dispose();
    _accountNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
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
              Text('Account Detail', style: FlexiFont.semiBold20),
              SizedBox(width: .06.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('Role', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _roleController,
            textStyle: FlexiFont.regular14
          ),
          SizedBox(height: .015.sh),
          Text('Account Name', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _accountNameController,
            textStyle: FlexiFont.regular14
          ),
          SizedBox(height: .015.sh),
          Text('User Name', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _userNameController,
            textStyle: FlexiFont.regular14
          ),
          SizedBox(height: .015.sh),
          Text('Email', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _emailController,
            textStyle: FlexiFont.regular14
          ),
          SizedBox(height: .25.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh, 
            text: 'Logout',
            fillColor: Colors.white,
            textColor: FlexiColor.secondary,
            onPressed: () async {
              // 저장된 계정 정보 삭제
              await ref.watch(accountControllerProvider.notifier).logout();
              isLogin = false;
              context.go('/');
            },
          )
        ],
      ),
    );
  }

}