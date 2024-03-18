import 'package:flexi/screens/utils/flexi_color.dart';
import 'package:flexi/screens/utils/flexi_font.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool passwordVisibility = false;
  Icon passwordVisibilityIcon = const Icon(Icons.visibility_off_outlined, color: Colors.white, size: 20);

  // text style
  TextStyle titleStyle = const TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.medium, fontSize: 24, color: Colors.white);
  TextStyle descriptionStyle = const TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: 12, color: Colors.white);
  TextStyle textFieldLabelStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: 16, color: Colors.white.withOpacity(0.5));
  TextStyle textFieldStyle = const TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: 16, color: Colors.white);
  TextStyle buttonStyle = const TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.medium, fontSize: 16, color: Colors.white);



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
    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: FlexiColor.primary,
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          const Expanded(
            flex: 5,
            child: Image(
              image: AssetImage("assets/image/login_illustration.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * .04),
                Text("Sign in", style: titleStyle),
                const SizedBox(height: 4),
                Text("Hi there! Nice to see you.", style: descriptionStyle),
                SizedBox(height: MediaQuery.sizeOf(context).height * .025),
                loginTextFieldFrame(
                  TextField(
                    controller: _emailController,
                    style: textFieldStyle,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: textFieldLabelStyle,
                      border: InputBorder.none,
                    ),
                  )
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                loginTextFieldFrame(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .5,
                        child: TextField(
                          controller: _passwordController,
                          style: textFieldStyle,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: textFieldLabelStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => switchPasswordVisibility(), 
                        icon: passwordVisibilityIcon
                      )
                    ],
                  )
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * .045),
                GestureDetector(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * .8,
                    height: MediaQuery.sizeOf(context).height * .06,
                    decoration: BoxDecoration(
                      color: FlexiColor.secondary,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(child: Text("Sign in", style: buttonStyle)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget loginTextFieldFrame(Widget childWidget) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .8,
      height: MediaQuery.sizeOf(context).height * .06,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: childWidget,
      )),
    );
  }

}