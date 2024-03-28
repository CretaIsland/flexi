import 'package:flexi/main.dart';
import 'package:flexi/screen/page/home_page.dart';
import 'package:flexi/screen/utils/flexi_color.dart';
import 'package:flexi/screen/utils/flexi_font.dart';
import 'package:flexi/screen/widget/button/text_button.dart';
import 'package:flexi/screen/widget/text_field/button_text_field.dart';
import 'package:flexi/screen/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';





class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // text style
  late TextStyle titleStyle;
  late TextStyle descriptionStyle;
  late TextStyle textFieldLabelStyle;
  late TextStyle textFieldStyle;
  late TextStyle buttonStyle;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool passwordVisibility = false;
  Icon passwordVisibilityIcon = const Icon(Icons.visibility_off_outlined, color: Colors.white, size: 20);


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

  // change password visibility state
  void switchPasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    setState(() {
      if(passwordVisibility) {  // show password
        passwordVisibilityIcon = const Icon(Icons.visibility_outlined, color: Colors.white, size: 20);
      } else {   // hide password
        passwordVisibilityIcon = const Icon(Icons.visibility_off_outlined, color: Colors.white, size: 20);
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    titleStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.medium, fontSize: screenHeight * .035, color: Colors.white);
    descriptionStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: screenHeight * .015, color: Colors.white);
    textFieldLabelStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: screenHeight * .02, color: Colors.white.withOpacity(0.5));
    textFieldStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: screenHeight * .02, color: Colors.white);
    buttonStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.medium, fontSize: screenHeight * .02, color: Colors.white);


    return Container(
      width: screenWidth,
      height: screenHeight,
      color: FlexiColor.primary,
      child: Column(
        children: [
          SizedBox(height: screenHeight * .05),
          Image(
            height: screenHeight * .51,
            image: const AssetImage("assets/image/login_illustration.png"),
            alignment: Alignment.topCenter,
          ),
          SizedBox(height: screenHeight * .03),
          SizedBox(
            width: screenWidth * .82,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sign in", style: titleStyle),
                SizedBox(height: screenHeight * .005,),
                Text("Hi there! Nice to see you.", style: descriptionStyle),
                SizedBox(height: screenHeight * .025),
                FlexiTextField(
                  textEditingController: _emailController,
                  width: screenWidth * .82, 
                  height: screenHeight * .06,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(screenHeight * .01),
                  labelTextStyle: FlexiFont.textFieldRegular.copyWith(color: Colors.white.withOpacity(0.5)),
                  valueTextStyle: FlexiFont.textFieldRegular.copyWith(color: Colors.white),
                  label: "Email",
                  contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .02, bottom: screenHeight * .02)
                ),
                SizedBox(height: screenHeight * .02),
                FlexiButtonTextField(
                  textEditingController: _passwordController, 
                  width: screenWidth * .82, 
                  height: screenHeight * .06, 
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(screenHeight * .01),
                  labelTextStyle: FlexiFont.textFieldRegular.copyWith(color: Colors.white.withOpacity(0.5)),
                  valueTextStyle: FlexiFont.textFieldRegular.copyWith(color: Colors.white),
                  label: "Password",
                  contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .02, bottom: screenHeight * .02),
                  actionButton: IconButton(
                    padding: const EdgeInsets.only(right: 12),
                    onPressed: switchPasswordVisibility,
                    icon: passwordVisibilityIcon,
                    iconSize: screenHeight * .02,
                  )
                ),
                SizedBox(height: screenHeight * .045),
                FlexiTextButton(
                  width: screenWidth * .82,
                  height: screenHeight * .06,
                  text: Text("Login", style: buttonStyle),
                  fillColor: FlexiColor.secondary,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}