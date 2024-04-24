import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/text_field.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';



class ContentInfoScreen extends ConsumerStatefulWidget {
  const ContentInfoScreen({super.key});

  @override
  ConsumerState<ContentInfoScreen> createState() => _ContentInfoScreenState();
}

class _ContentInfoScreenState extends ConsumerState<ContentInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.screenColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .04, right: screenWidth * .055, bottom: screenHeight * .02),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.go("/content/list"),
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: FlexiColor.primary),
                        iconSize: screenHeight * .015,
                      ),
                      SizedBox(width: screenWidth * .2),
                      Text("Content Detail", style: FlexiFont.semiBold20,),
                    ],
                  ),
                  SizedBox(height: screenHeight * .03),
                  Container(
                    width: screenWidth * .89,
                    height: screenHeight * .0375,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(screenHeight * .005)
                    ),
                    child: const Center(child: Text("Sample Text")),
                  ),
                  SizedBox(height: screenHeight * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => context.go("/content/editText"),
                        child: Container(
                          width: screenWidth * .43,
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(screenHeight * .01)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: screenHeight * .1,
                                height: screenHeight * .1,
                                decoration: BoxDecoration(
                                  color: FlexiColor.primary.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(screenHeight * .05)
                                ),
                                child: Center(child: Icon(Icons.title, color: FlexiColor.primary, size: screenHeight * .05))
                              ),
                              Text("Edit Text", style: FlexiFont.semiBold16.copyWith(color: FlexiColor.primary))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go("/content/editBackground"),
                        child: Container(
                          width: screenWidth * .43,
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(screenHeight * .01)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: screenHeight * .1,
                                height: screenHeight * .1,
                                decoration: BoxDecoration(
                                  color: FlexiColor.primary.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(screenHeight * .05)
                                ),
                                child: Center(child: Icon(Icons.photo_outlined, color: FlexiColor.primary, size: screenHeight * .05))
                              ),
                              Text("Edit Background", style: FlexiFont.semiBold16.copyWith(color: FlexiColor.primary))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: FlexiColor.grey[400]),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .015, right: screenWidth * .055, bottom: screenHeight * .02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name", style: FlexiFont.regular14),
                  SizedBox(height: screenHeight * .01),
                  FlexiTextField(width: screenWidth * .89, height: screenHeight * .06, textEditingController: TextEditingController()),
                  SizedBox(height: screenHeight * .015),
                  Text("Resoultion", style: FlexiFont.regular14),
                  SizedBox(height: screenHeight * .015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("width", style: FlexiFont.regular14),
                      SizedBox(width: screenWidth * .033),
                      FlexiTextField(width: screenWidth * .22, height: screenHeight * .045, textEditingController: TextEditingController()),
                      SizedBox(width: screenWidth * .1),
                      Text("height", style: FlexiFont.regular14),
                      SizedBox(width: screenWidth * .033),
                      FlexiTextField(width: screenWidth * .22, height: screenHeight * .045, textEditingController: TextEditingController()),
                    ],
                  ),
                  SizedBox(height: screenHeight * .015),
                  Text("Location", style: FlexiFont.regular14),
                  SizedBox(height: screenHeight * .015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("X", style: FlexiFont.regular14),
                      SizedBox(width: screenWidth * .033),
                      FlexiTextField(width: screenWidth * .22, height: screenHeight * .045, textEditingController: TextEditingController()),
                      SizedBox(width: screenWidth * .165),
                      Text("Y", style: FlexiFont.regular14),
                      SizedBox(width: screenWidth * .033),
                      FlexiTextField(width: screenWidth * .22, height: screenHeight * .045, textEditingController: TextEditingController()),
                    ],
                  )
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
      )
    );
  }
  
}