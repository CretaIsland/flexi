import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../component/text_field.dart';
import '../../../core/controller/network_controller.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/utils.dart';
import '../modal/bluetooth_list_modal.dart';



class DeviceInfoScreen extends ConsumerStatefulWidget {
  const DeviceInfoScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends ConsumerState<DeviceInfoScreen> {

  final TextEditingController _deviceNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _deviceNameController.text = ref.watch(deviceInfoControllerProvider).deviceName;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _deviceNameController.dispose();
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
                Text('Device Detail', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () async {
                    if(await ref.watch(socketClientControllerProvider.notifier).connect(device.ip)) {
                      await ref.watch(socketClientControllerProvider.notifier).sendData({
                        'command': 'playerSetting',
                        'deviceId': device.deviceId,
                        'deviceName': _deviceNameController.text,
                        'name': _deviceNameController.text,
                        'volume': device.volume
                      });
                      FlexiUtils.showAlertMsg('Send setting value');
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
                            device.bluetoothBonded ? Icon(Icons.bluetooth, size: .045.sh, color: FlexiColor.primary)
                              : Icon(Icons.bluetooth_disabled, size: .045.sh, color: FlexiColor.secondary),
                            SizedBox(height: .015.sh),
                            device.bluetoothBonded ? Text(device.bluetooth, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: FlexiColor.primary))
                              : Text('Bluetooth OFF', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: FlexiColor.secondary))
                          ]
                        )
                      ),
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
              controller: _deviceNameController
            ),
            SizedBox(height: .015.sh),
            Text('Device Name', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            Container(
              width: .89.sw, 
              height: .06.sh,
              padding: EdgeInsets.only(left: .055.sw, right: .055.sw),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: FlexiColor.grey[400]!),
                borderRadius: BorderRadius.circular(.01.sh)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => ref.watch(deviceInfoControllerProvider.notifier).setVolume(0),
                    child: Icon(Icons.volume_mute_rounded, size: .03.sh, color: FlexiColor.primary)
                  ),
                  SizedBox(
                    width: .65.sw,
                    height: .02.sh,
                    child: Slider(
                      value: device.volume * 1.0,
                      max: 100.0,
                      activeColor: FlexiColor.primary,
                      thumbColor: FlexiColor.primary,
                      onChanged: (value) => ref.watch(deviceInfoControllerProvider.notifier).setVolume(value.toInt())
                    )
                  ),
                  GestureDetector(
                    onTap: () => ref.watch(deviceInfoControllerProvider.notifier).setVolume(100),
                    child: Icon(Icons.volume_up, size: .03.sh, color: FlexiColor.primary)
                  )
                ]
              )
            ),
            SizedBox(height: .015.sh),
            Text('Device Timezone', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              readOnly: true,
              hintText: device.timeZone
            ),
            SizedBox(height: .015.sh),
            Text('Connected Network', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              readOnly: true,
              hintText: device.registeredSSID
            ),
            SizedBox(height: .015.sh),
          ]
        )
      )
    );
  }
}