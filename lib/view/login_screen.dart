import '../component/text_button.dart';
import '../feature/auth/controller/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/ui/color.dart';
import '../utils/ui/font.dart';



class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  late AuthController _authController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _hidePasswordProvider = StateProvider((ref) => true);


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authController = AuthController();
    _authController.initialize();
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
                child: Image.asset(
                  'assets/image/login_illustration.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                )
              ),
              SizedBox(height: .03.sh),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign in', style: FlexiFont.semiBold24.copyWith(color: Colors.white)),
                  SizedBox(height: .005.sh),
                  Text('Hi there! Nice to see you.', style: FlexiFont.regular12.copyWith(color: Colors.white)),
                  SizedBox(height: .025.sh),
                  SizedBox(
                    width: .82.sw, 
                    height: .06.sh,
                    child: TextField(
                      controller: _emailController,
                      style: FlexiFont.regular16.copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 12),
                        hintText: 'Email',
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
                      ),
                    ),
                  ),
                  SizedBox(height: .015.sh),
                  SizedBox(
                    width: .82.sw, 
                    height: .06.sh,
                    child: TextField(
                      controller: _passwordController,
                      style: FlexiFont.regular16.copyWith(color: Colors.white),
                      obscureText: ref.watch(_hidePasswordProvider),
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
                        suffixIcon: InkWell(
                          onTap: () => ref.watch(_hidePasswordProvider.notifier).state = !ref.watch(_hidePasswordProvider),
                          child: Icon(
                            ref.watch(_hidePasswordProvider) ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.white,
                            size: .025.sh
                          ),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: .025.sh),
                  FlexiTextButton(
                    width: .82.sw, 
                    height: .06.sh, 
                    text: 'Login',
                    fillColor: FlexiColor.secondary,
                    onPressed: () {
                      _authController.loginByEmail(_emailController.text, _passwordController.text).then((value) {
                        if(currentUser != null) {
                          context.go('/device/list');
                        } else {
                          // 토스트 메세지
                        }
                      });
                    },
                  ),
                  SizedBox(height: .035.sh),
                  InkWell(
                    onTap: () {
                      _authController.loginByGoogle().then((value) {
                        if(currentUser != null) {
                          context.go('/device/list');
                        } else {
                          // 토스트 메세지
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
                          Image.asset(
                            'assets/image/google_logo.png',
                            height: .03.sh,
                          ),
                          SizedBox(width: .02.sw),
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
      ),
    );
  }
  
}