import 'package:flexi/main.dart';
import 'package:flexi/screen/page/login_page.dart';
import 'package:flexi/screen/utils/flexi_font.dart';
import 'package:flexi/screen/widget/button/text_button.dart';
import 'package:flexi/screen/widget/scaffold/app_bar.dart';
import 'package:flexi/screen/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';

import '../../utils/flexi_color.dart';

class AccountDetailPage extends StatelessWidget {

  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: FlexiColor.grey[200],
      padding: EdgeInsets.only(top: screenHeight * .04, left: screenWidth * .066, right: screenWidth * .066, bottom: screenHeight * .035),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FlexiAppBar(title: "Account Detail", pageName: "/setting"),
          SizedBox(height: screenHeight * .03),
          Text("Role", style: FlexiFont.displayRegular14),
          SizedBox(height: screenHeight * .01),
          FlexiTextField(
            width: screenWidth * .88,
            height: screenHeight * .06,
            border: Border.all(color: FlexiColor.grey[400]!),
            borderRadius: BorderRadius.circular(screenHeight *.01),
            textEditingController: TextEditingController(text: "Admin"),
            contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .02, bottom: screenHeight * .02),
          ),
          SizedBox(height: screenHeight * .015),
          Text("Account Name", style: FlexiFont.displayRegular14),
          SizedBox(height: screenHeight * .01),
          FlexiTextField(
            width: screenWidth * .88,
            height: screenHeight * .06,
            border: Border.all(color: FlexiColor.grey[400]!),
            borderRadius: BorderRadius.circular(screenHeight *.01),
            textEditingController: TextEditingController(text: "Demo Account"),
            contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .02, bottom: screenHeight * .02),
          ),
          SizedBox(height: screenHeight * .015),
          Text("User Name", style: FlexiFont.displayRegular14),
          SizedBox(height: screenHeight * .01),
          FlexiTextField(
            width: screenWidth * .88,
            height: screenHeight * .06,
            border: Border.all(color: FlexiColor.grey[400]!),
            borderRadius: BorderRadius.circular(screenHeight *.01),
            textEditingController: TextEditingController(text: "KFF Admin"),
            contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .02, bottom: screenHeight * .02),
          ),
          SizedBox(height: screenHeight * .015),
          Text("Email", style: FlexiFont.displayRegular14),
          SizedBox(height: screenHeight * .01),
          FlexiTextField(
            width: screenWidth * .88,
            height: screenHeight * .06,
            border: Border.all(color: FlexiColor.grey[400]!),
            borderRadius: BorderRadius.circular(screenHeight *.01),
            textEditingController: TextEditingController(text: "kff-admi@kmail.plala.or.jp"),
            contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .02, bottom: screenHeight * .02),
          ),
          SizedBox(height: screenHeight * .255),
          FlexiTextButton(
            width: screenWidth * .88,
            height: screenHeight * .06,
            fillColor: Colors.white,
            text: Text("Log out", style: FlexiFont.textButtonSemibold16.copyWith(color: FlexiColor.secondary)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
          )
        ]
      ),
    );

  }



}