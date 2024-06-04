import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/text_button.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class DeviceRecoveryScreen extends ConsumerStatefulWidget {
  const DeviceRecoveryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceRecoveryScreenState();
}

class _DeviceRecoveryScreenState extends ConsumerState<DeviceRecoveryScreen> {
  
  late TextEditingController _deviceIdController;


  @override
  void initState() {
    super.initState();
    _deviceIdController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _deviceIdController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.go('/settings'), 
                icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh)
              ),
              Text('Device Recovery', style: FlexiFont.semiBold20),
              SizedBox(width: .06.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('Device ID', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          SizedBox(
            width: .89.sw,
            height: .06.sh,
            child: TextField(
              controller: _deviceIdController,
              style: FlexiFont.regular16.copyWith(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 12),
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(.01.sh),
                  borderSide: BorderSide(color: FlexiColor.grey[400]!)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(.01.sh),
                  borderSide: BorderSide(color: FlexiColor.grey[400]!)
                ),
                suffixIcon: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.document_scanner_outlined,
                    color: FlexiColor.primary, 
                    size: .025.sh
                  ),
                )
              ),
            ),
          ),
          SizedBox(height: .02.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh,
            fillColor: FlexiColor.primary, 
            text: 'Recover',
            onPressed: () {
              // 앱스토어로 이동
            },
          )
        ],
      ),
    );
  }

}