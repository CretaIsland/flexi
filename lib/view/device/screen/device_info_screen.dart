import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../core/controller/socket_client_controller.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../util/design/colors.dart';
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
  final TextEditingController _timeZoneController = TextEditingController();
  final TextEditingController _connectedWifiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameController.text = ref.watch(deviceInfoControllerProvider).deviceName;
      _timeZoneController.text = ref.watch(deviceInfoControllerProvider).timeZone;
      _connectedWifiController.text = ref.watch(deviceInfoControllerProvider).registeredSSID;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _timeZoneController.dispose();
    _connectedWifiController.dispose();
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
                  icon: Icon(Icons.arrow_back_ios_rounded, size: .025.sh, color: FlexiColor.primary)
                ),
                Text('Device Detail', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () async {
                    var connected = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                    if(connected) {
                      await ref.watch(socketClientControllerProvider.notifier).sendData({
                        "command": "playerSetting",
                        "deviceId": device.deviceId,
                        "deviceName": _nameController.text,
                        "name": _nameController.text,
                        "volume": device.volume
                      });
                      Fluttertoast.showToast(
                        msg: 'Send setting value',
                        backgroundColor: Colors.black.withOpacity(.8),
                        textColor: Colors.white,
                        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
                      );
                    }
                  },
                  child: Text('OK', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary))
                )
              ]
            ),
            SizedBox(height: .03.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Network', style: Theme.of(context).textTheme.bodySmall),
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
                          Icon(Icons.wifi_rounded, size: .045.sh, color: FlexiColor.primary),
                          SizedBox(height: .015.sh),
                          Text('Connected', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: FlexiColor.primary))
                        ]
                      )
                    )
                  ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Speaker', style: Theme.of(context).textTheme.bodySmall),
                    SizedBox(height: .01.sh),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: widget.rootContext,
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
                            device.bluetoothBonded ?
                              Icon(Icons.bluetooth_rounded, size: .045.sh, color: FlexiColor.primary) :
                              Icon(Icons.bluetooth_disabled_rounded, size: .045.sh, color: FlexiColor.secondary),
                            SizedBox(height: .015.sh),
                            device.bluetoothBonded ?
                              Text(device.bluetooth, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: FlexiColor.primary)) :
                              Text('Bluetooth OFF', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: FlexiColor.secondary))
                          ]
                        )
                      )
                    )
                  ]
                )
              ]
            ),
            SizedBox(height: .03.sh),
            Text('Device Name', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _nameController
            ),
            SizedBox(height: .015.sh),
            Text('Device Volume', style: Theme.of(context).textTheme.bodySmall),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => ref.watch(deviceInfoControllerProvider.notifier).setVolume(0), 
                    icon: Icon(Icons.volume_mute_rounded, size: .03.sh, color: FlexiColor.primary)
                  ),
                  SizedBox(
                    width: .6.sw,
                    height: .02.sh,
                    child: Slider(
                      value: device.volume * 1.0,
                      max: 100.0,
                      activeColor: FlexiColor.primary,
                      thumbColor: FlexiColor.primary,
                      onChanged: (value) => ref.watch(deviceInfoControllerProvider.notifier).setVolume(value.toInt())
                    )
                  ),
                  IconButton(
                    onPressed: () => ref.watch(deviceInfoControllerProvider.notifier).setVolume(100), 
                    icon: Icon(Icons.volume_up_rounded, size: .03.sh, color: FlexiColor.primary)
                  )
                ],
              )
            ),
            SizedBox(height: .015.sh),
            Text('Device Timezone', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _timeZoneController,
              readOnly: true
            ),
            SizedBox(height: .015.sh),
            Text('Connected Network', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _connectedWifiController,
              readOnly: true
            ),
            SizedBox(height: .015.sh),
          ]
        )
      )
    );
  }
}