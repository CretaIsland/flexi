import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../util/design/colors.dart';
import '../../../component/text_button.dart';



class DeviceRecoveryScreen extends StatefulWidget {
  const DeviceRecoveryScreen({super.key});

  @override
  State<DeviceRecoveryScreen> createState() => _DeviceRecoveryScreenState();
}

class _DeviceRecoveryScreenState extends State<DeviceRecoveryScreen> {

  final TextEditingController _idController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
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
                onPressed: () => context.go('/setting'), 
                icon: Icon(Icons.arrow_back_ios, size: .025.sh, color: FlexiColor.primary)
              ),
              Text('Device Recovery', style: Theme.of(context).textTheme.displaySmall),
              SizedBox(width: .05.sh)
            ],
          ),
          SizedBox(height: .03.sh),
          Text('Device ID', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: .01.sh),
          SizedBox(
            width: .89.sw,
            height: .06.sh,
            child: TextField(
              controller: _idController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 12),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.document_scanner_outlined, size: .025.sh, color: FlexiColor.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(.01.sh),
                  borderSide: BorderSide(color: FlexiColor.grey[400]!)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(.01.sh),
                  borderSide: BorderSide(color: FlexiColor.grey[400]!)
                )
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ),
          SizedBox(height: .02.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh, 
            text: 'Recover',
            backgroundColor: FlexiColor.primary
          )
        ],
      ),
    );
  }

}