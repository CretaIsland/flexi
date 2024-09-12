import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/content/controller/content_info_controller.dart';
import '../../../util/design/colors.dart';
import '../../../component/text_field.dart';
import '../component/content_preview.dart';



class ContentInfoScreen extends ConsumerStatefulWidget {
  const ContentInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentInfoScreenState();
}

class _ContentInfoScreenState extends ConsumerState<ContentInfoScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _xController = TextEditingController();
  final TextEditingController _yController = TextEditingController();
  bool _screenLock = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameController.text = ref.watch(contentInfoControllerProvider).contentName;
      _widthController.text = ref.watch(contentInfoControllerProvider).width.toString();
      _heightController.text = ref.watch(contentInfoControllerProvider).height.toString();
      _xController.text = ref.watch(contentInfoControllerProvider).x.toString();
      _yController.text = ref.watch(contentInfoControllerProvider).y.toString();
    });
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
    var content = ref.watch(contentInfoControllerProvider);
    var contentInfoController = ref.watch(contentInfoControllerProvider.notifier);

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
                  onPressed: () {
                    contentInfoController.save().then((value) => context.go('/content/list'));
                  }, 
                  icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh)
                ),
                Text('Content Detail', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () => contentInfoController.save().then((value) {
                    context.go('/content/send');
                  }),
                  child: Text('Send', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
            SizedBox(height: .03.sh),
            ContentPreview(width: .89.sw, height: .04.sh, content: content),
            SizedBox(height: .02.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                editButton('Edit Text', Icons.title, '/content/editText'),
                editButton('Edit Background', Icons.photo_outlined, '/content/editBackground')
              ],
            ),
            SizedBox(height: .035.sh),
            Text('Name', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _nameController,
              onChanged: (value) => contentInfoController.setName(_nameController.text),
            ),
            SizedBox(height: .03.sh),
            Text('Resolution', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: .055.sw),
                Text('width', style: Theme.of(context).textTheme.bodySmall),
                FlexiTextField(
                  width: .25.sw, 
                  height: .045.sh,
                  controller: _widthController,
                  onChanged: (value) => contentInfoController.setWidth(int.parse(_widthController.text)),
                ),
                Text('height', style: Theme.of(context).textTheme.bodySmall),
                FlexiTextField(
                  width: .25.sw, 
                  height: .045.sh,
                  controller: _heightController,
                  onChanged: (value) => contentInfoController.setHeight(int.parse(_heightController.text)),
                )
              ],
            ),
            SizedBox(height: .03.sh),
            Text('Location', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: .055.sw),
                Text('X', style: Theme.of(context).textTheme.bodySmall),
                FlexiTextField(
                  width: .25.sw, 
                  height: .045.sh,
                  controller: _xController,
                  onChanged: (value) => contentInfoController.setX(int.parse(_xController.text)),
                ),
                Text('Y', style: Theme.of(context).textTheme.bodySmall),
                FlexiTextField(
                  width: .25.sw, 
                  height: .045.sh,
                  controller: _yController,
                  onChanged: (value) => contentInfoController.setY(int.parse(_yController.text)),
                ),
              ],
            ),
            SizedBox(height: .035.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reverse', style: Theme.of(context).textTheme.bodySmall),
                AdvancedSwitch(
                  width: .1.sw,
                  height: .025.sh,
                  initialValue: content.isReverse,
                  activeColor: FlexiColor.primary,
                  onChanged: (value) => contentInfoController.setReverse(value),
                )
              ],
            ),
            SizedBox(height: .03.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lock', style: Theme.of(context).textTheme.bodySmall),
                AdvancedSwitch(
                  width: .1.sw,
                  height: .025.sh,
                  initialValue: _screenLock,
                  activeColor: FlexiColor.primary,
                  onChanged: (value) => setState(() {
                    _screenLock = value;
                  }),
                )
              ],
            ),
            SizedBox(height: .05.sh)
          ],
        ),
      )
    );
  }

  Widget editButton(String text, IconData icon, String routePath) {
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
            Text(text, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: FlexiColor.primary)),
          ],
        ),
      ),
    );
  }

}