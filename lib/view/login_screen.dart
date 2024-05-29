import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../components/text_button.dart';
import '../utils/ui/colors.dart';
import '../utils/ui/fonts.dart';



class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {


  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _hidePasswordProvider = StateProvider<bool>((ref) => true);


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
              SizedBox(height: .05.sh),
              SizedBox(
                width: 1.sw,
                height: .5.sh,
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
                    onPressed: () {
                      // 로그인 확인
                      // 맞으면 계정 정보 저장
                      context.go('/device/list');
                    },
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