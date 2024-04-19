import 'package:flexi/utils/colors.dart';
import 'package:flexi/utils/fonts.dart';
import 'package:flexi/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _passwordVisibility = false;


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



  void changePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenWidth,
        color: FlexiColor.primary,
        child: Column(
          children: [
            SizedBox(height: screenHeight * .05125),
            const Expanded(
              flex: 51,
              child: Image(
                image: AssetImage("assets/image/login_illustration.png"),
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Expanded(
              flex: 44,
              child: Column(
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
                      controller: _emailController,
                      style: FlexiFont.regular16.copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(screenHeight * .01),
                          borderSide: const BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(screenHeight * .01),
                          borderSide: const BorderSide(color: Colors.white)
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .018125, bottom: screenHeight * .018125),
                        hintText: "Email",
                        hintStyle: FlexiFont.regular16.copyWith(color: Colors.white.withOpacity(.5)),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * .02),
                  Container(
                    width: screenWidth * .82,
                    height: screenHeight * .06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenHeight * .01),
                      border: Border.all(color: Colors.white)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * .6,
                          child: TextField(
                            controller: _passwordController,
                            style: FlexiFont.regular16.copyWith(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .018125, bottom: screenHeight * .018125),
                              hintText: "Password",
                              hintStyle: FlexiFont.regular16.copyWith(color: Colors.white.withOpacity(.5)),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: changePasswordVisibility, 
                          icon: _passwordVisibility 
                            ? Icon(Icons.visibility_outlined, color: Colors.white, size: screenHeight * .025) 
                            : Icon(Icons.visibility_off_outlined, color: Colors.white, size: screenHeight * .025)
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * .045),
                  SizedBox(
                    width: screenWidth * .82,
                    height: screenHeight * .06,
                    child: TextButton(
                      onPressed: () {
                        context.go("/device/list");
                      }, 
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
            )
          ],
        ),
      )
    );
  }
}