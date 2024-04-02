import 'package:flexi/view/content/content_info_screen.dart';
import 'package:flexi/view/content/content_list_screen.dart';
import 'package:flexi/view/content/edit_background_screen.dart';
import 'package:flexi/view/content/edit_text_screen.dart';
import 'package:flexi/view/content/send_content_screen.dart';
import 'package:flexi/view/device/device_list_screen.dart';
import 'package:flexi/view/login_screen.dart';
import 'package:flexi/view/setting/account_info_screen.dart';
import 'package:flexi/view/setting/app_info_screen.dart';
import 'package:flexi/view/setting/device_recovery_screen.dart';
import 'package:flexi/view/setting/setting_menu_screen.dart';
import 'package:go_router/go_router.dart';



GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => const NoTransitionPage(child: LoginScreen()),
    ),
    GoRoute(
      path: "/device",
      redirect: (context, state) {
        return "/device/list";
      },
      routes: [
        GoRoute(
          path: "list",
          pageBuilder: (context, state) => const NoTransitionPage(child: DeviceListScreen()),
        ),
        GoRoute(
          path: "info",
          pageBuilder: (context, state) => const NoTransitionPage(child: DeviceListScreen()),
        ),
        GoRoute(
          path: "setTimezone",
          pageBuilder: (context, state) => const NoTransitionPage(child: DeviceListScreen()),
        ),
        GoRoute(
          path: "setWifi",
          pageBuilder: (context, state) => const NoTransitionPage(child: DeviceListScreen()),
        )
      ]
    ),
    GoRoute(
      path: "/content",
      redirect: (context, state) => "/content/list",
      routes: [
        GoRoute(
          path: "list",
          pageBuilder: (context, state) => const NoTransitionPage(child: ContentListScreen()),
        ),
        GoRoute(
          path: "info",
          pageBuilder: (context, state) => const NoTransitionPage(child: ContentInfoScreen()),
        ),
        GoRoute(
          path: "editText",
          pageBuilder: (context, state) => const NoTransitionPage(child: EditTextScreen()),
        ),
        GoRoute(
          path: "editBackground",
          pageBuilder: (context, state) => const NoTransitionPage(child: EditBackgroundScreen()),
        ),
        GoRoute(
          path: "sendDevice",
          pageBuilder: (context, state) => const NoTransitionPage(child: SendContentScreen()),
        )
      ]
    ),
    GoRoute(
      path: "/setting",
      redirect: (context, state) => "/setting/menu",
      routes: [
        GoRoute(
          path: "menu",
          pageBuilder: (context, state) => const NoTransitionPage(child: SettingMenuScreen()),
        ),
        GoRoute(
          path: "accountInfo",
          pageBuilder: (context, state) => const NoTransitionPage(child: AccountInfoScreen()),
        ),
        GoRoute(
          path: "appInfo",
          pageBuilder: (context, state) => const NoTransitionPage(child: AppInfoScreen()),
        ),
        GoRoute(
          path: "deviceRecovery",
          pageBuilder: (context, state) => const NoTransitionPage(child: DeviceRecoveryScreen()),
        ),
      ]
    )
  ]
);