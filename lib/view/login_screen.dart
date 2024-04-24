import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {


  // text edit controller
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
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: EdgeInsets.only(top: screenHeight * .05125),
        color: FlexiColor.primary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * .5,
                child: const Image(
                  image: AssetImage("assets/image/login_illustration.png"),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * .03),
                  Text("Sign in", style: FlexiFont.semiBold24.copyWith(color: Colors.white)),
                  SizedBox(height: screenHeight * .005,),
                  Text("Hi there! Nice to see you.", style: FlexiFont.regular12.copyWith(color: Colors.white)),
                  SizedBox(height: screenHeight * .025),
                  SizedBox(
                    width: screenWidth * .82,
                    height: screenHeight * .06,
                    child: TextField(
                      controller: null,
                      style: FlexiFont.regular16.copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(screenHeight * .01),
                          borderSide: BorderSide(color: FlexiColor.grey[400]!)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(screenHeight * .01),
                          borderSide: BorderSide(color: FlexiColor.grey[400]!)
                        ),
                        hintText: "Email",
                        hintStyle: FlexiFont.regular16.copyWith(color: Colors.white)
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * .02),
                  Container(
                    width: screenWidth * .82,
                    height: screenHeight * .06,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(screenHeight * .01)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * .6,
                          child: TextField(
                            controller: null,
                            style: FlexiFont.regular16.copyWith(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 12),
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: FlexiFont.regular16.copyWith(color: Colors.white)
                            ),
                            obscureText: ref.watch(_hidePasswordProvider),
                          ),
                        ),
                        IconButton(
                          onPressed: () => ref.watch(_hidePasswordProvider.notifier).state = !ref.watch(_hidePasswordProvider),
                          icon: Icon(ref.watch(_hidePasswordProvider) ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.white, size: screenHeight * .025)
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * .045),
                  SizedBox(
                    width: screenWidth * .82,
                    height: screenHeight * .06,
                    child: TextButton(
                      onPressed: () => context.go("/device/list"),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                        ),
                        backgroundColor: MaterialStateProperty.all(FlexiColor.secondary),
                      ), 
                      child: Text("Sign in", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}