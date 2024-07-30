import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/content_send_controller.dart';
import '../../../util/ui/colors.dart';
import '../../../util/ui/fonts.dart';
import '../../common/component/search_bar.dart';
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
    var selectDevices = ref.watch(selectDevicesProvider);
    var devices = ref.watch(connectedDeviceControllerProvider);
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
                  onPressed: () => context.go('/content/info'),
                  icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: FlexiColor.primary),
                ),
                Text('Send to device', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () => showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const ContentSendModal()
                  ), 
                  child: Text('Send', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your device',
              onChanged: (value) => setState(() {
                _searchText = value;
              })
            ),
            SizedBox(height: .04.sh),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return devices[index].deviceName.contains(_searchText) ? GestureDetector(
                    onTap: () {
                      if(selectDevices.contains(devices[index])) {
                        selectDevices.remove(devices[index]);
                        ref.watch(selectDevicesProvider.notifier).state = [...ref.watch(selectDevicesProvider)];
                      } else {
                        ref.watch(selectDevicesProvider.notifier).state = [...ref.watch(selectDevicesProvider), devices[index]];
                      }
                    },
                    child: Container(
                      width: .89.sw,
                      height: .1.sh,
                      padding: EdgeInsets.only(left: .04.sw, right: .04.sw),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(.01.sh)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: .02.sh),
                              Row(
                                children: [
                                  Icon(Icons.link_rounded, color: FlexiColor.primary, size: .02.sh),
                                  SizedBox(width: .015.sh),
                                  Text(devices[index].deviceName, style: FlexiFont.regular16,)
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: .03.sh),
                                child: Text(devices[index].deviceId, style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                              )
                            ],
                          ),
                          ref.watch(selectDevicesProvider).contains(devices[index]) ? 
                            Icon(Icons.check_circle, color: FlexiColor.primary, size: .025.sh) :
                            Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                        ],
                      ),              
                    ),
                  ) : const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  
}