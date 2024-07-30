import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'common/component/text_button.dart';
import '../feature/setting/controller/user_controller.dart';
import '../util/ui/colors.dart';
import '../util/ui/fonts.dart';



class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _hidePassword = true;

  final UserController _userController = UserController();
  final TextStyle _loginformStyle = FlexiFont.regular16.copyWith(color: Colors.white);
  final OutlineInputBorder _loginformBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(.01.sh),
    borderSide: BorderSide(color: FlexiColor.grey[400]!)
  );

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userController.initialize();
  }

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
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: .05.sh),
              SizedBox(
                width: 1.sw,
                height: .45.sh,
                child: Image.asset(
                  'assets/image/login_illustration.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter
                )
              ),
              SizedBox(height: .03.sh),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Login',style: FlexiFont.semiBold24.copyWith(color: Colors.white)),
                  SizedBox(height: .005.sh),
                  Text('Hi there! Nice to see you', style: FlexiFont.regular12.copyWith(color: Colors.white)),
                  SizedBox(height: .025.sh),
                  // Email text field
                  SizedBox(
                    width: .82.sw,
                    height: .06.sh,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: _loginformStyle,
                        contentPadding: const EdgeInsets.only(left: 12),
                        enabledBorder: _loginformBorder,
                        focusedBorder: _loginformBorder
                      ),
                      style: _loginformStyle
                    )
                  ),
                  SizedBox(height: .02.sh),
                  // Password text field
                  SizedBox(
                    width: .82.sw,
                    height: .06.sh,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: _loginformStyle,
                        contentPadding: const EdgeInsets.only(left: 12),
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() {
                            _hidePassword = !_hidePassword;
                          }),
                          child: Icon(_hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: .025.sh, color: Colors.white),
                        ),
                        enabledBorder: _loginformBorder,
                        focusedBorder: _loginformBorder
                      ),
                      style: _loginformStyle,
                      obscureText: _hidePassword
                    )
                  ),
                  SizedBox(height: .025.sh),
                  FlexiTextButton(
                    width: .82.sw, 
                    height: .06.sh, 
                    text: 'Login',
                    backgroundColor: FlexiColor.secondary,
                    onPressed: () {
                      print('button');
                      _userController.loginByEmail(_emailController.text, _passwordController.text).then((value) {
                        if(value != null) {
                          ref.watch(loginUser.notifier).state = value;
                          context.go('/device/list');
                        } else {
                          Fluttertoast.showToast(
                            msg: 'login fail',
                            backgroundColor: Colors.black.withOpacity(.8),
                            textColor: Colors.white,
                            fontSize: FlexiFont.regular20.fontSize
                          );
                        }
                      });
                    },
                  ),
                  SizedBox(height: .035.sh),
                  InkWell(
                    onTap: () {
                      _userController.loginByGoogle().then((value) {
                        if(value != null) {
                          ref.watch(loginUser.notifier).state = value;
                          context.go('/device/list');
                        } else {
                          Fluttertoast.showToast(
                            msg: 'login fail',
                            backgroundColor: Colors.black.withOpacity(.8),
                            textColor: Colors.white,
                            fontSize: FlexiFont.regular20.fontSize
                          );
                        }
                      });
                    },
                    child: Container(
                      width: .82.sw,
                      height: .06.sh,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(.01.sh)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/image/google_logo.png', height: .03.sh),
                          SizedBox(width: .05.sw),
                          Text('Login by Google', style: FlexiFont.semiBold16)
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

}