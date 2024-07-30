import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/setting/controller/user_controller.dart';
import '../../../util/ui/colors.dart';
import '../../../util/ui/fonts.dart';
import '../../common/component/text_button.dart';
import '../../common/component/text_field.dart';



class AccountInfoScreen extends ConsumerStatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends ConsumerState<AccountInfoScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _enterpriseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailController.text = ref.watch(loginUser)!.email;
      _nicknameController.text = ref.watch(loginUser)!.nickname;
      _enterpriseController.text = ref.watch(loginUser)!.enterprise;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nicknameController.dispose();
    _enterpriseController.dispose();
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
                icon: Icon(Icons.arrow_back_ios, size: .025.sh, color: FlexiColor.primary)
              ),
              Text('Account Detail', style: FlexiFont.semiBold20),
              SizedBox(width: .05.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('User Name', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _nicknameController,
            textStyle: FlexiFont.regular16,
            readOnly: true
          ),
          SizedBox(height: .015.sh),
          Text('Email', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _emailController,
            textStyle: FlexiFont.regular16,
            readOnly: true
          ),
          SizedBox(height: .015.sh),
          Text('Enterprise', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _enterpriseController,
            textStyle: FlexiFont.regular16,
            readOnly: true
          ),
          SizedBox(height: .35.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh, 
            text: 'Logout',
            backgroundColor: Colors.white,
            textColor: FlexiColor.secondary,
            onPressed: () {
              UserController().logout();
              ref.invalidate(loginUser);
              context.go('/login');
            }
          )
        ]
      )
    );
  }

}