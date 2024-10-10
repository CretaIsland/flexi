import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../component/search_bar.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/device/controller/connected_device_controller.dart';
import '../../../util/design/colors.dart';
import '../modal/content_send_modal.dart';



class ContentSendScreen extends ConsumerStatefulWidget {
  const ContentSendScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentSendScreenState();
}

class _ContentSendScreenState extends ConsumerState<ContentSendScreen> {

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    ref.watch(contentInfoControllerProvider);
    var devices = ref.watch(connectedDeviceControllerProvider);
    var selectDevices = ref.watch(selectDevicesProvider);
    return Scaffold(
      backgroundColor: FlexiColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go('/content/detail'), 
                  icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh)
                ),
                Text('Select Device', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () {
                    if(selectDevices.isEmpty) return;
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context, 
                      builder: (context) => const ContentSendModal(),
                    );
                  },
                  child: Text('Send', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary))
                )
              ]
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your device',
              onChanged: (value) => setState(() => _searchText = value)
            ),
            SizedBox(height: .04.sh),
            Expanded(
              child: devices.isEmpty ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: .03.sh, 
                    height: .03.sh, 
                    child: CircularProgressIndicator(
                      color: FlexiColor.grey[600],
                      strokeWidth: 2.5
                    )
                  ),
                  SizedBox(height: .015.sh),
                  Text('Scanning for nearby device', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600]))
                ]
              ) : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: devices.length,
                itemBuilder: (context, index) => devices[index].deviceName.toLowerCase().contains(_searchText.toLowerCase()) ? GestureDetector(
                  onTap: () {
                    if(selectDevices.contains(devices[index])) {
                      selectDevices.remove(devices[index]);
                      ref.watch(selectDevicesProvider.notifier).state = [...selectDevices];
                    } else {
                      ref.watch(selectDevicesProvider.notifier).state = [...selectDevices, devices[index]];
                    }
                  },
                  child: Container(
                    width: .89.sw,
                    height: .1.sh,
                    padding: EdgeInsets.only(left: .055.sw, right: .055.sw),
                    margin: EdgeInsets.only(bottom: .02.sh),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(.01.sh)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.link_rounded, size: .045.sw, color: FlexiColor.primary),
                                SizedBox(width: .015.sw),
                                Text(devices[index].deviceName, style: Theme.of(context).textTheme.bodyMedium)
                              ]
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: .06.sw),
                              child: Text(devices[index].deviceId, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: FlexiColor.grey[600]))
                            )
                          ]
                        ),
                        selectDevices.contains(devices[index]) ? Icon(Icons.check_circle, size: .025.sh, color: FlexiColor.primary) 
                          : Icon(Icons.check_circle_outline, size: .025.sh, color: FlexiColor.grey[600])
                      ]
                    )
                  )
                ) : const SizedBox.shrink()
              )
            )
          ]
        )
      )
    );
  }
}