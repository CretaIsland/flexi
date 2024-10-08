import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../component/bottom_navigation_bar.dart';
import '../../../component/text_button.dart';
import '../../../component/text_field.dart';
import '../../../feature/auth/controller/user_controller.dart';
import '../../../util/design/colors.dart';



class AccountInfoScreen extends ConsumerStatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends ConsumerState<AccountInfoScreen> {

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _enterpriseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nicknameController.text = ref.watch(userControllerProvider)!.nickname;
      _emailController.text = ref.watch(userControllerProvider)!.email;
      _enterpriseController.text = ref.watch(userControllerProvider)!.enterprise;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
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
            ]
          ),
          SizedBox(height: .03.sh),
          Text('User Name', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            readOnly: true,
            controller: _nicknameController
          ),
          SizedBox(height: .015.sh),
          Text('Email', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            readOnly: true,
            controller: _emailController
          ),
          SizedBox(height: .015.sh),
          Text('Enterprise', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: .01.sh),
          FlexiTextField(
            width: .89.sw, 
            height: .06.sh,
            readOnly: true,
            controller: _enterpriseController
          ),
          SizedBox(height: .35.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh, 
            text: 'Logout',
            textColor: FlexiColor.secondary,
            onPressed: () async {
              await ref.watch(userControllerProvider.notifier).logout();
              ref.invalidate(currentTabProvider);
              if(context.mounted) {
                context.go('/login');
              }
            }
          )
        ]
      )
    );
  }
}