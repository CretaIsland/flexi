import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../../utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/ui/fonts.dart';

class DeviceRecoveryScreen extends ConsumerStatefulWidget {
  const DeviceRecoveryScreen({super.key});

  @override
  ConsumerState<DeviceRecoveryScreen> createState() => _DeviceRecoveryScreenState();
}

class _DeviceRecoveryScreenState extends ConsumerState<DeviceRecoveryScreen> {
  
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
              Text("Device Recovery", style: FlexiFont.semiBold20),
              SizedBox(width: screenHeight * .05)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .03, right: screenWidth * .055, bottom: screenHeight * .03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Device ID", style: FlexiFont.regular14,),
                const SizedBox(height: 8),
                SizedBox(
                  width: screenWidth * .89,
                  height: screenHeight * .06,
                  child: TextField(
                    style: FlexiFont.regular14,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 12),
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenHeight * .01),
                        borderSide: BorderSide(color: FlexiColor.grey[400]!)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenHeight * .01),
                        borderSide: BorderSide(color: FlexiColor.grey[400]!)
                      ),
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Icon(Icons.qr_code_2_outlined, color: FlexiColor.primary, size: screenHeight * .025)
                      )
                    ),
                  ),
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
                    child: Text("Recover", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
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