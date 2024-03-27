import 'package:flexi/main.dart';
import 'package:flexi/screens/utils/flexi_font.dart';
import 'package:flexi/screens/widget/app_bar.dart';
import 'package:flutter/material.dart';

class AccountDetailPage extends StatelessWidget {

  const AccountDetailPage({super.key});


  @override
  Widget build(BuildContext context) {

    TextStyle fieldLabelStyle = TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: screenHeight * .02, color: Colors.black);
    
    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * .04, left: screenWidth * .055, right: screenWidth * .055),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(child: FlexiAppBar(title: "Account Detail")),
              SizedBox(height: screenHeight * .03),
              Text("Role", style: fieldLabelStyle),
              SizedBox(height: screenHeight * .01),
              textFieldFrame("Admin"),
              SizedBox(height: screenHeight * .015),
              Text("Account Name", style: fieldLabelStyle),
              SizedBox(height: screenHeight * .01),
              textFieldFrame("Demo Account"),
              SizedBox(height: screenHeight * .015),
              Text("User Name", style: fieldLabelStyle),
              SizedBox(height: screenHeight * .01),
              textFieldFrame("KFF Administrator"),
              SizedBox(height: screenHeight * .015),
              Text("Email", style: fieldLabelStyle),
              SizedBox(height: screenHeight * .01),
              textFieldFrame("kff-admi@kmail.plala.or.jp"),
            ],
          ),
        ),
      ),
    );
  }


  Widget textFieldFrame(String value) {
    return Container(
      width: screenWidth * .88,
      height: screenHeight * .06,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(screenWidth *.022)
      ),
      child: TextField(
        controller: TextEditingController(text: value),
        style: TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: screenHeight * .02, color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .02, bottom: screenHeight * .02),
          hintText: "Email",
          hintStyle: TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: screenHeight * .02, color: Colors.black),
          border: InputBorder.none
        ),
      )
    );
  }



}