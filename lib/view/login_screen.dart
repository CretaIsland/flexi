import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../component/text_button.dart';
import '../feature/auth/service/auth_service.dart';
import '../utils/ui/color.dart';
import '../utils/ui/font.dart';



class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  late AuthService _authService;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _hidePasswordProvider = StateProvider<bool>((ref) => true);


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authService = AuthService();
    _authService.initialize();
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
                child: const Image(
                  image: AssetImage('assets/image/login_illustration.png'),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: .03.sh),
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
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: .02.sh),
                  SizedBox(
                    width: .82.sw,
                    height: .06.sh,
                    child: TextField(
                      controller: _passwordController,
                      style: FlexiFont.regular16.copyWith(color: Colors.white),
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
                          onTap: () {},
                          child: Icon(
                            ref.watch(_hidePasswordProvider) ? Icons.visibility_off_outlined : Icons.visibility_outlined, 
                            color: Colors.white, 
                            size: .025.sh
                          ),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: .045.sh),
                  FlexiTextButton(
                    width: .82.sw, 
                    height: .06.sh, 
                    text: 'Login',
                    fillColor: FlexiColor.secondary,
                    onPressed: () async {
                      var result = await _authService.loginByEmail(_emailController.text, _passwordController.text);
                      if(result) {
                        context.go('/device/list');
                      }
                    },
                  ),
                  SizedBox(height: .025.sh),
                  InkWell(
                    onTap: () async {
                      var result = await _authService.loginByGoogle();
                      if(result) {
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
                          SizedBox(
                            height: .03.sh,
                            child: Image.asset(
                              'assets/image/google_logo.png',
                            ),
                          ),
                          SizedBox(width: .05.sw),
                          Text('Login By Google', style: FlexiFont.semiBold16,)
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