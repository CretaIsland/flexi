import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../components/text_field.dart';
import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';



class AccountInfoScreen extends ConsumerStatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  ConsumerState<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends ConsumerState<AccountInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.backgroundColor,
      child: Column(
        children: [
          SizedBox(height: screenHeight * .04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.go("/setting/menu"),
                icon: Icon(Icons.arrow_back_ios_new, color: FlexiColor.primary),
                iconSize: screenHeight * .025,
              ),
              Text("Account Detail", style: FlexiFont.semiBold20),
              SizedBox(width: screenHeight * .05)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .03, right: screenWidth * .055, bottom: screenHeight * .03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Role", style: FlexiFont.regular14,),
                const SizedBox(height: 8),
                FlexiTextField(width: screenWidth * .89, height: screenHeight * .06, fillColor: Colors.transparent),
                const SizedBox(height: 12),
                Text("Account Name", style: FlexiFont.regular14,),
                const SizedBox(height: 8),
                FlexiTextField(width: screenWidth * .89, height: screenHeight * .06, fillColor: Colors.transparent),
                const SizedBox(height: 12),
                Text("User Name", style: FlexiFont.regular14,),
                const SizedBox(height: 8),
                FlexiTextField(width: screenWidth * .89, height: screenHeight * .06, fillColor: Colors.transparent),
                const SizedBox(height: 12),
                Text("Email", style: FlexiFont.regular14,),
                const SizedBox(height: 8),
                FlexiTextField(width: screenWidth * .89, height: screenHeight * .06, fillColor: Colors.transparent),
                SizedBox(height: screenHeight * .2),
                SizedBox(
                  width: screenWidth * .89,
                  height: screenHeight * .06,
                  child: TextButton(
                    onPressed: () => context.go("/"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ), 
                    child: Text("Log out", style: FlexiFont.semiBold16.copyWith(color: FlexiColor.secondary))
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

}