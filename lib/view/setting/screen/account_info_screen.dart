import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/setting/controller/auth_controller.dart';
import '../../../util/design/colors.dart';
import '../../../component/bottom_navigation_bar.dart';
import '../../../component/text_button.dart';
import '../../../component/text_field.dart';



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
      _emailController.text = ref.watch(authControllerProvider)!.email;
      _nicknameController.text = ref.watch(authControllerProvider)!.nickname;
      _enterpriseController.text = ref.watch(authControllerProvider)!.enterprise;
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
                onPressed: () => context.go('/setting'), 
                icon: Icon(Icons.arrow_back_ios, size: .025.sh, color: FlexiColor.primary)
              ),
              Text('Account Detail', style: Theme.of(context).textTheme.displaySmall),
              SizedBox(width: .05.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('User Name', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _nicknameController,
            readOnly: true
          ),
          SizedBox(height: .015.sh),
          Text('Email', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _emailController,
            readOnly: true
          ),
          SizedBox(height: .015.sh),
          Text('Enterprise', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            controller: _enterpriseController,
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
              ref.watch(authControllerProvider.notifier).logout();
              ref.invalidate(currentTabProvider);
              context.go('/login');
            }
          )
        ]
      )
    );
  }

}