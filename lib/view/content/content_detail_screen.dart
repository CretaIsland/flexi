import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:go_router/go_router.dart';

import '../../components/text_field.dart';
import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';
import 'component/content_preview.dart';



class ContentDetailScreen extends StatefulWidget {
  const ContentDetailScreen({super.key});

  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * .04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go("/content/list"),
                  icon: Icon(Icons.arrow_back_ios_new, color: FlexiColor.primary),
                  iconSize: screenHeight * .025,
                ),
                Text("Content Detail", style: FlexiFont.semiBold20),
                SizedBox(width: screenHeight * .05)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .03, right: screenWidth * .055),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentPreview(
                    width: screenWidth * .89, 
                    height: screenHeight * .0375
                  ),
                  SizedBox(height: screenHeight * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      iconButton(
                        "Edit Text", 
                        Icons.title_outlined, 
                        () => context.go("/content/editText")
                      ),
                      iconButton(
                        "Edit Background", 
                        Icons.photo_outlined, 
                        () => context.go("/content/editBackground")
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * .03),
                  Text("Name", style: FlexiFont.regular14),
                  const SizedBox(height: 8),
                  FlexiTextField(width: screenWidth * .89, height: screenHeight * .06),
                  const SizedBox(height: 12),
                  Text("Resolution", style: FlexiFont.regular14),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: screenWidth * .05),
                      Text("width", style: FlexiFont.regular14),
                      SizedBox(width: screenWidth * .033),
                      FlexiTextField(width: screenWidth * .22, height: screenHeight * .045, textEditingController: TextEditingController()),
                      SizedBox(width: screenWidth * .1),
                      Text("height", style: FlexiFont.regular14),
                      SizedBox(width: screenWidth * .033),
                      FlexiTextField(width: screenWidth * .22, height: screenHeight * .045, textEditingController: TextEditingController()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text("Location", style: FlexiFont.regular14),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: screenWidth * .1),
                      Text("X", style: FlexiFont.regular14),
                      SizedBox(width: screenWidth * .033),
                      FlexiTextField(width: screenWidth * .22, height: screenHeight * .045, textEditingController: TextEditingController()),
                      SizedBox(width: screenWidth * .165),
                      Text("Y", style: FlexiFont.regular14),
                      SizedBox(width: screenWidth * .033),
                      FlexiTextField(width: screenWidth * .22, height: screenHeight * .045, textEditingController: TextEditingController()),
                    ],
                  ),
                  SizedBox(height: screenHeight * .015)
                ],
              ),
            ),
            Divider(color: FlexiColor.grey[400]),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .015, right: screenWidth * .055, bottom: screenHeight * .035),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Reverse", style: FlexiFont.regular14),
                      AdvancedSwitch(
                        width: screenWidth * .11,
                        height: screenHeight * .025,
                        activeColor: FlexiColor.primary,
                        onChanged: (value) {},
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lock", style: FlexiFont.regular14),
                      AdvancedSwitch(
                        width: screenWidth * .11,
                        height: screenHeight * .025,
                        activeColor: FlexiColor.primary,
                        onChanged: (value) {},
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * .05),
                  SizedBox(
                    width: screenWidth * .89,
                    height: screenHeight * .06,
                    child: TextButton(
                      onPressed: () => context.go("/content/sendDevice"),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                        ),
                        backgroundColor: MaterialStateProperty.all(FlexiColor.primary),
                      ), 
                      child: Text("Send", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget iconButton(String btnLabel, IconData btnIcon, void Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: screenWidth * .43,
        height: screenHeight * .2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenHeight * .1,
              height: screenHeight * .1,
              decoration: BoxDecoration(
                color: FlexiColor.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(screenHeight * .05)
              ),
              child: Center(
                child: Icon(btnIcon, color: FlexiColor.primary, size: screenHeight * .05),
              ),
            ),
            const SizedBox(height: 10),
            Text(btnLabel, style: FlexiFont.semiBold16.copyWith(color: FlexiColor.primary))
          ],
        ),
      ),
    );
  }

}