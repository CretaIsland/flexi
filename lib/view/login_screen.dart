import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../component/text_button.dart';
import '../feature/setting/controller/user_controller.dart';
import '../util/design/colors.dart';
import '../util/utils.dart';



class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlexiColor.primary,
      body: Padding(
        padding: EdgeInsets.only(left: .09.sw, top: .05.sh, right: .09.sw),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: .55.sh,
                child: Image.asset('assets/image/login_illustration.png')
              ),
              SizedBox(height: .03.sh),
              Text('Login', style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white)),
              SizedBox(height: .005.sh),
              Text('Hi there! Nice to see you', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white)),
              SizedBox(height: .025.sh),
              SizedBox(
                width: .82.sw,
                height: .06.sh,
                child: TextField(
                  controller: _emailController,
                  cursorWidth: 1.0,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white, decorationThickness: 0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: .025.sw),
                    hintText: 'Email',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(.01.sh)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(.01.sh)
                    )
                  )
                )
              ),
              SizedBox(height: .02.sh),
              SizedBox(
                width: .82.sw,
                height: .06.sh,
                child: TextField(
                  controller: _passwordController,
                  cursorWidth: 1.0,
                  obscureText: _hidePassword,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white, decorationThickness: 0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: .025.sw),
                    hintText: 'Password',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(.01.sh)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(.01.sh)
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => _hidePassword = !_hidePassword),
                      child: Icon(_hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: .025.sh, color: Colors.white)
                    )
                  )
                )
              ),
              SizedBox(height: .025.sh),
              FlexiTextButton(
                width: .82.sw,
                height: .06.sh, 
                text: 'Login',
                backgroundColor: FlexiColor.secondary,
                onPressed: () async {
                  if(await ref.watch(userControllerProvider.notifier).loginByEmail(_emailController.text, _passwordController.text)) {
                    if(context.mounted) context.go('/device/list');
                  } else {
                    FlexiUtils.showMsg('Incorrect email or password');
                  }
                }
              )
            ]
          )
        )
      )
    );
  }
}