import 'package:go_router/go_router.dart';

import '../../components/text_field.dart';
import '../../main.dart';
import '../../utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/ui/fonts.dart';

class AppInfoScreen extends ConsumerStatefulWidget {
  const AppInfoScreen({super.key});

  @override
  ConsumerState<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends ConsumerState<AppInfoScreen> {
  
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
              Text("App Update", style: FlexiFont.semiBold20),
              SizedBox(width: screenHeight * .05)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .03, right: screenWidth * .055, bottom: screenHeight * .03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("App version", style: FlexiFont.regular14,),
                const SizedBox(height: 8),
                FlexiTextField(
                  width: screenWidth * .89,
                  height: screenHeight * .06,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: screenWidth * .89,
                  height: screenHeight * .06,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                      ),
                      backgroundColor: MaterialStateProperty.all(FlexiColor.primary),
                    ), 
                    child: Text("Check For Updates", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
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