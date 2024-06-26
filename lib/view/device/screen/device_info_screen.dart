import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../common/providers/socket_client_controller.dart';
import '../../../component/text_field.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';
import '../modal/bluetooth_list_modal.dart';



class DeviceInfoScreen extends ConsumerStatefulWidget {
  const DeviceInfoScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends ConsumerState<DeviceInfoScreen> {

  late TextEditingController _nameController;
  late TextEditingController _timezoneController;
  late TextEditingController _ssidController;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: ref.watch(deviceInfoControllerProvider)!.deviceName);
    _timezoneController = TextEditingController(text: ref.watch(deviceInfoControllerProvider)!.timeZone);
    _ssidController = TextEditingController(text: ref.watch(deviceInfoControllerProvider)!.registeredSSID);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _timezoneController.dispose();
    _ssidController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var deviceInfoController = ref.watch(deviceInfoControllerProvider.notifier);
    var deviceInfo = ref.watch(deviceInfoControllerProvider);

    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      child: SingleChildScrollView(
        child: Column(
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
                  onPressed: () async {
                    deviceInfoController.setName(_nameController.text);
                    Map<String, dynamic> data = {
                      "command": "playerSetting",
                      "deviceId": deviceInfo!.deviceId,
                      "deviceName": deviceInfo.deviceName,
                      "name": deviceInfo.deviceName,
                      "volume": deviceInfo.volume
                    };
                    bool connect = await ref.watch(socketClientControllerProvider.notifier).connect(deviceInfo.ip);
                    if(connect) ref.watch(socketClientControllerProvider.notifier).sendData(data);
                  },
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
                      onTap: () => showModalBottomSheet(
                        context: widget.rootContext,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const BluetoothModal(),
                      ),
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
                            deviceInfo!.bluetoothBonded ? 
                              Icon(Icons.bluetooth, color: FlexiColor.primary, size: .045.sh) :
                              Icon(Icons.bluetooth_disabled, color: FlexiColor.secondary, size: .045.sh),
                            deviceInfo.bluetoothBonded ?
                              Text(deviceInfo.bluetooth, style: FlexiFont.semiBold14.copyWith(color: FlexiColor.primary)) :
                              Text('Bluetooth Off', style: FlexiFont.semiBold14.copyWith(color: FlexiColor.secondary))
                          ]
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
              controller: _nameController,
              backgroundColor: Colors.white,
              textStyle: FlexiFont.regular16
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
                      value: deviceInfo.volume * 1.0,
                      max: 100.0,
                      activeColor: FlexiColor.primary,
                      thumbColor: Colors.white,
                      onChanged: (value) {
                        ref.watch(deviceInfoControllerProvider.notifier).setVolume(value.toInt());
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
              readOnly: true,
              controller: TextEditingController(text: deviceInfo.timeZone),
              backgroundColor: Colors.white,
              textStyle: FlexiFont.regular16
            ),
            SizedBox(height: .015.sh),
            Text('Network', style: FlexiFont.regular14),
            SizedBox(height: .01.sh),
            FlexiTextField(
              readOnly: true,
              controller: TextEditingController(text: deviceInfo.registeredSSID),
              backgroundColor: Colors.white,
              textStyle: FlexiFont.regular16
            )
          ],
        ),
      ),
    );
  }

}