import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/text_field.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class DeviceInfoScreen extends ConsumerStatefulWidget {
  const DeviceInfoScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends ConsumerState<DeviceInfoScreen> {

  late TextEditingController _deviceNameController;
  late TextEditingController _deviceTimezoneController;
  late TextEditingController _connectedNetworkController;


  @override
  void initState() {
    super.initState();
    _deviceNameController = TextEditingController();
    _deviceTimezoneController = TextEditingController();
    _connectedNetworkController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _deviceNameController.dispose();
    _deviceTimezoneController.dispose();
    _connectedNetworkController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go('/device/list'),
                  icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh),
                ),
                Text('Device Detail', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () {},
                  child: Text('OK', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
                )
              ],
            ),
            SizedBox(height:  .03.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Network', style: FlexiFont.regular14),
                    SizedBox(height: .01.sh),
                    Container(
                      width: .43.sw,
                      height: .125.sh,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(.01.sh)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi, color: FlexiColor.primary, size: .045.sh),
                          Text('Connected', style: FlexiFont.semiBold14.copyWith(color: FlexiColor.primary))
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bluetooth', style: FlexiFont.regular14),
                    SizedBox(height: .01.sh),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: .43.sw,
                        height: .125.sh,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(.01.sh)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bluetooth, color: FlexiColor.primary, size: .045.sh),
                            Text('Device name', style: FlexiFont.semiBold14.copyWith(color: FlexiColor.primary))
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: .015.sh),
            Text('Device Name', style: FlexiFont.regular14),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _deviceNameController,
            ),
            SizedBox(height: .015.sh),
            Text('Device Volume', style: FlexiFont.regular14),
            SizedBox(height: .01.sh),
            Container(
              width: .89.sw, 
              height: .06.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: FlexiColor.grey[400]!),
                borderRadius: BorderRadius.circular(.01.sh)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.volume_mute_rounded, color: FlexiColor.primary, size: .03.sh),
                  ),
                  SizedBox(
                    width: .6.sw,
                    height: .02.sh,
                    child: Slider(
                      value: 50.0,
                      max: 100.0,
                      activeColor: FlexiColor.primary,
                      thumbColor: Colors.white,
                      onChanged: (value) {

                      }
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.volume_up_rounded, color: FlexiColor.primary, size: .03.sh),
                  ),
                ]
              ),
            ),
            SizedBox(height: .015.sh),
            Text('Device Timezone', style: FlexiFont.regular14),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _deviceTimezoneController,
            ),
            SizedBox(height: .015.sh),
            Text('Network', style: FlexiFont.regular14),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _connectedNetworkController,
            )
          ],
        ),
      ),
    );
  }

}