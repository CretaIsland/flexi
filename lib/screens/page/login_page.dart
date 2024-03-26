import 'package:flexi/screens/utils/flexi_color.dart';
import 'package:flexi/screens/utils/flexi_font.dart';
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
    
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    titleStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.medium, fontSize: height * .035, color: Colors.white);
    descriptionStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: height * .015, color: Colors.white);
    textFieldLabelStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: height * .02, color: Colors.white.withOpacity(0.5));
    textFieldStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: height * .02, color: Colors.white);
    buttonStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.medium, fontSize: height * .02, color: Colors.white);


    return Container(
      width: width,
      height: height,
      color: FlexiColor.primary,
      child: Column(
        children: [
          SizedBox(height: height * .05),
          Image(
            height: height * .51,
            image: const AssetImage("assets/image/login_illustration.png"),
            alignment: Alignment.topCenter,
          ),
          SizedBox(height: height * .03),
          SizedBox(
            width: width * .82,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sign in", style: titleStyle),
                SizedBox(height: height * .005,),
                Text("Hi there! Nice to see you.", style: descriptionStyle),
                SizedBox(height: height * .025),
                textFieldFrame(
                  width: width * .82,
                  height: height * .06,
                  childWidget: TextField(
                    controller: _emailController,
                    style: textFieldStyle,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 12, top: height * .02, bottom: height * .02),
                      hintText: "Email",
                      hintStyle: textFieldLabelStyle,
                      border: InputBorder.none
                    ),
                  )
                ),
                SizedBox(height: height * .02),
                textFieldFrame(
                  width: width * .82,
                  height: height * .06,
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * .6,
                        height: height * .06,
                        child: TextField(
                          controller: _passwordController,
                          style: textFieldStyle,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 12, top: height * .02, bottom: height * .02),
                            hintText: "Password",
                            hintStyle: textFieldLabelStyle,
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(right: 12),
                        onPressed: switchPasswordVisibility, 
                        icon: passwordVisibilityIcon,
                        iconSize: height * .02,
                      ),
                    ],
                  )
                ),
                SizedBox(height: height * .045),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                  child: Container(
                    width: width * .82,
                    height: height * .06,
                    decoration: BoxDecoration(
                      color: FlexiColor.secondary,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: Text("Login", style: buttonStyle),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldFrame({required double width, required double height, required Widget childWidget}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(height / 6)
      ),
      child: childWidget
    );
  }



}