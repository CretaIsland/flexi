import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/text_button.dart';
import '../../../component/text_field.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';
import '../component/content_preview.dart';



class ContentInfoScreen extends ConsumerStatefulWidget {
  const ContentInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentInfoScreenState();
}

class _ContentInfoScreenState extends ConsumerState<ContentInfoScreen> {

  late TextEditingController _nameController;
  late TextEditingController _widthController;
  late TextEditingController _heightController;
  late TextEditingController _xController;
  late TextEditingController _yController;

  final screenLockProvider = StateProvider<bool>((ref) => false);


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _widthController = TextEditingController();
    _heightController = TextEditingController();
    _xController = TextEditingController();
    _yController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _xController.dispose();
    _yController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final contentInfo = ref.watch(contentInfoControllerProvider);
    final contentInfoController = ref.watch(contentInfoControllerProvider.notifier);

    _nameController.text = contentInfo.contentName;
    _widthController.text = contentInfo.width.toString();
    _heightController.text = contentInfo.height.toString();
    _xController.text = contentInfo.x.toString();
    _yController.text = contentInfo.y.toString();


    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw, bottom: .02.sh),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        contentInfoController.saveChange();
                        context.go('/content/list');
                      }, 
                      icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh)
                    ),
                    Text('Content Detail', style: FlexiFont.semiBold20),
                    SizedBox(width: .06.sh)
                  ],
                ),
                SizedBox(height: .03.sh),
                ContentPreview(
                  previewWidth: .89.sw,
                  previewHeight: .04.sh,
                  contentInfo: contentInfo
                ),
                SizedBox(height: .02.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    editButton('Edit Text', Icons.title, '/content/editText'),
                    editButton('Edit Background', Icons.photo_outlined, '/content/editBackground')
                  ],
                ),
              ],
            ),
          ),
          Divider(color: FlexiColor.grey[400]),
          Padding(
            padding: EdgeInsets.only(left: .055.sw, top: .015.sh, right: .055.sw, bottom: .015.sh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name', style: FlexiFont.regular14),
                SizedBox(height: .01.sh),
                FlexiTextField(
                  width: .89.sw, 
                  height: .06.sh,
                  controller: _nameController,
                  onChanged: (value) => contentInfoController.setName(_nameController.text),
                ),
                SizedBox(height: .03.sh),
                Text('Resolution', style: FlexiFont.regular14),
                SizedBox(height: .01.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: .055.sw),
                    Text('width', style: FlexiFont.regular14),
                    FlexiTextField(
                      width: .25.sw, 
                      height: .045.sh,
                      controller: _widthController,
                      onChanged: (value) => contentInfoController.setWidth(int.parse(_widthController.text)),
                    ),
                    Text('height', style: FlexiFont.regular14),
                    FlexiTextField(
                      width: .25.sw, 
                      height: .045.sh,
                      controller: _heightController,
                      onChanged: (value) => contentInfoController.setWidth(int.parse(_heightController.text)),
                    )
                  ],
                ),
                SizedBox(height: .03.sh),
                Text('Location', style: FlexiFont.regular14),
                SizedBox(height: .01.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: .055.sw),
                    Text('X', style: FlexiFont.regular14),
                    FlexiTextField(
                      width: .25.sw, 
                      height: .045.sh,
                      controller: _xController,
                      onChanged: (value) => contentInfoController.setX(int.parse(_xController.text)),
                    ),
                    Text('Y', style: FlexiFont.regular14),
                    FlexiTextField(
                      width: .25.sw, 
                      height: .045.sh,
                      controller: _yController,
                      onChanged: (value) => contentInfoController.setY(int.parse(_yController.text)),
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(color: FlexiColor.grey[400]),
          Padding(
            padding: EdgeInsets.only(left: .055.sw, top: .015.sh, right: .055.sw, bottom: .015.sh),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Reverse', style: FlexiFont.regular14),
                    AdvancedSwitch(
                      width: .1.sw,
                      height: .025.sh,
                      initialValue: contentInfo.isReverse,
                      activeColor: FlexiColor.primary,
                      onChanged: (value) => contentInfoController.setReverse(!contentInfo.isReverse),
                    )
                  ],
                ),
                SizedBox(height: .02.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lock', style: FlexiFont.regular14),
                    AdvancedSwitch(
                      width: .1.sw,
                      height: .025.sh,
                      initialValue: ref.watch(screenLockProvider),
                      activeColor: FlexiColor.primary,
                      onChanged: (value) => ref.watch(screenLockProvider.notifier).state = value,
                    )
                  ],
                ),
                SizedBox(height: .05.sh),
                FlexiTextButton(
                  width: .89.sw, 
                  height: .06.sh, 
                  text: 'Send',
                  backgroundColor: FlexiColor.primary,
                  onPressed: () {
                    contentInfoController.saveChange();
                    context.go('/content/send');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget editButton(String label, IconData icon, String routePath) {
    return InkWell(
      onTap: () => context.go(routePath),
      child: Container(
        width: .43.sw,
        height: .2.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(.01.sh)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: .1.sh,
              height: .1.sh,
              decoration: BoxDecoration(
                color: FlexiColor.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(.05.sh)
              ),
              child: Center(
                child: Icon(icon, color: FlexiColor.primary, size: .05.sh),
              ),
            ),
            SizedBox(height: .01.sh),
            Text(label, style: FlexiFont.semiBold16.copyWith(color: FlexiColor.primary)),
          ],
        ),
      ),
    );
  }

}