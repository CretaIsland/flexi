import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/socket_client_controller.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/design/fonts.dart';
import '../../../component/text_field.dart';
import '../modal/bluetooth_list_modal.dart';



class DeviceInfoScreen extends ConsumerStatefulWidget {
  const DeviceInfoScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends ConsumerState<DeviceInfoScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timezoneController = TextEditingController();
  final TextEditingController _networkController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameController.text = ref.watch(deviceInfoControllerProvider).deviceName;
      _timezoneController.text = ref.watch(deviceInfoControllerProvider).timeZone;
      _networkController.text = ref.watch(deviceInfoControllerProvider).registeredSSID;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _timezoneController.dispose();
    _networkController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var device = ref.watch(deviceInfoControllerProvider);
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
                  icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: FlexiColor.primary)
                ),
                Text('Device Detail', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () async {
                    Map<String, dynamic> data = {
                      "command": "playerSetting",
                      "deviceId": device.deviceId,
                      "deviceName": _nameController.text,
                      "name": device.deviceName,
                      "volume": device.volume
                    };
                    var connect = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                    if(connect) ref.watch(socketClientControllerProvider.notifier).sendData(data);
                  },
                  child: Text('OK', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
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
                    Text('Speaker', style: FlexiFont.regular14),
                    SizedBox(height: .01.sh),
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: widget.rootContext,
                        isScrollControlled: true,
                        builder: (context) => const BluetoothListModal()
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
                            device.bluetoothBonded ? Icon(Icons.bluetooth, color: FlexiColor.primary, size: .045.sh) :
                              Icon(Icons.bluetooth_disabled, color: FlexiColor.secondary, size: .045.sh),
                            device.bluetoothBonded ? Text(device.bluetooth, style: FlexiFont.semiBold14.copyWith(color: FlexiColor.primary)) :
                              Text('Bluetooth Off', style: FlexiFont.semiBold14.copyWith(color: FlexiColor.secondary))
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
                      value: device.volume * 1.0,
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
              width: .89.sw,
              height: .06.sh,
              readOnly: true,
              controller: TextEditingController(text: device.timeZone),
              backgroundColor: Colors.white,
              textStyle: FlexiFont.regular16
            ),
            SizedBox(height: .015.sh),
            Text('Network', style: FlexiFont.regular14),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw,
              height: .06.sh,
              readOnly: true,
              controller: TextEditingController(text: device.registeredSSID),
              backgroundColor: Colors.white,
              textStyle: FlexiFont.regular16
            )
          ],
        ),
      ),
    );
  }

}