import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../component/text_button.dart';
import '../component/text_field.dart';
import '../feature/auth/controller/auth_service.dart';
import '../utils/ui/color.dart';
import '../utils/ui/font.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late AuthController _authController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool _hidePassword;

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
    _authController.initialize();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _hidePassword = true;
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
        width: 1.sw,
        height: 1.sh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: .045.sh),
              SizedBox(
                width: 1.sw,
                height: .45.sh,
                child: Image.asset('assets/image/login_illustration.png', fit: BoxFit.contain, alignment: Alignment.bottomCenter),
              ),  
              SizedBox(height: .03.sh),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign in', style: FlexiFont.semiBold24.copyWith(color: Colors.white)),
                  SizedBox(height: .005.sh),
                  Text('Hi there! Nice to see you.', style: FlexiFont.regular12.copyWith(color: Colors.white)),
                  SizedBox(height: .025.sh),
                  // email text field
                  FlexiTextField(
                    width: .82.sw, 
                    height: .06.sh,
                    controller: _emailController,
                    textStyle: FlexiFont.regular16.copyWith(color: Colors.white),
                    hintText: 'Email',
                    backgroundColor: Colors.transparent
                  ),
                  SizedBox(height: .015.sh),
                  // password text field
                  SizedBox(
                    width: .82.sw,
                    height: .06.sh,
                    child: TextField(
                      controller: _passwordController,
                      style: FlexiFont.regular16.copyWith(color: Colors.white),
                      obscureText: _hidePassword,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 12),
                        hintText: 'Password',
                        hintStyle: FlexiFont.regular16.copyWith(color: Colors.white),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(.01.sh),
                          borderSide: const BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(.01.sh),
                          borderSide: const BorderSide(color: Colors.white)
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() {
                            _hidePassword = !_hidePassword;  
                          }),
                          child: Icon(
                            _hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.white,
                            size: .025.sh
                          )
                        )
                      )
                    )
                  ),
                  SizedBox(height: .025.sh),
                  // login by email
                  FlexiTextButton(
                    width: .82.sw, 
                    height: .06.sh, 
                    text: 'Login',
                    backgroundColor: FlexiColor.secondary,
                    onPressed: () async {
                      await _authController.loginByEmail(_emailController.text, _passwordController.text);
                      if(currentUser != null) {
                        context.go('/device/list');
                      }
                    }
                  ),
                  SizedBox(height: .035.sh),
                  // login by google
                  InkWell(
                    onTap: () async {
                      await _authController.loginByGoogle();
                      if(currentUser != null) {
                        context.go('/device/list');
                      }
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
                          SizedBox(width: .02.sw),
                          Text('Login by Google', style: FlexiFont.semiBold16)
                        ]
                      )
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}