import 'package:flexi/view/content/content_info_screen.dart';
import 'package:flexi/view/content/content_list_screen.dart';
import 'package:flexi/view/content/edit_background_screen.dart';
import 'package:flexi/view/content/edit_text_screen.dart';
import 'package:flexi/view/content/send_content_screen.dart';
import 'package:flexi/view/device/device_info_screen.dart';
import 'package:flexi/view/device/device_list_screen.dart';
import 'package:flexi/view/device/device_timezone_set_screen.dart';
import 'package:flexi/view/device/device_wifi_set_screen.dart';
import 'package:flexi/view/home_screen.dart';
import 'package:flexi/view/login_screen.dart';
import 'package:flexi/view/setting/account_info_screen.dart';
import 'package:flexi/view/setting/app_info_screen.dart';
import 'package:flexi/view/setting/device_recovery_screen.dart';
import 'package:flexi/view/setting/setting_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavKey = GlobalKey<NavigatorState>();


GoRouter router = GoRouter(
  navigatorKey: rootNavKey,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => const NoTransitionPage(child: LoginScreen()),
    ),
    // bottomNavigationBar가 있는 화면
    ShellRoute(
      navigatorKey: shellNavKey,
      builder: (context, state, child) => HomeScreen(state: state, child: child),
      routes: [
        // 디바이스 관련 화면
        GoRoute(
          path: "/device/setTimezone",
          pageBuilder: (context, state) => const NoTransitionPage(child: DeviceTimezoneSetScreen()),
        ),
        // 콘텐츠 관련 화면
        GoRoute(
          path: "/content/list",
          pageBuilder: (context, state) => const NoTransitionPage(child: ContentListScreen()),
        ),
        GoRoute(
          path: "/content/info",
          pageBuilder: (context, state) => const NoTransitionPage(child: ContentInfoScreen()),
        ),
        // 설정 관련 화면
        GoRoute(
          path: "/setting/menu",
          pageBuilder: (context, state) => const NoTransitionPage(child: SettingMenuScreen()),
        ),
        GoRoute(
          path: "/setting/accountInfo",
          pageBuilder: (context, state) => const NoTransitionPage(child: AccountInfoScreen()),
        ),
        GoRoute(
          path: "/setting/appInfo",
          pageBuilder: (context, state) => const NoTransitionPage(child: AppInfoScreen()),
        ),
        GoRoute(
          path: "/setting/deviceRecovery",
          pageBuilder: (context, state) => const NoTransitionPage(child: DeviceRecoveryScreen()),
        ),
      ]
    ),
    // bottomNavigationBar가 없는 화면
    GoRoute(
      path: "/device/list",
      pageBuilder: (context, state) => const NoTransitionPage(child: DeviceListScreen()),
    ),
    GoRoute(
      path: "/device/info",
      pageBuilder: (context, state) => const NoTransitionPage(child: DeviceInfoScreen()),
    ),
    GoRoute(
      path: "/device/setWifi",
      pageBuilder: (context, state) => const NoTransitionPage(child: DeviceWifiSetScreen()),
    ),
    GoRoute(
      path: "/content/editText",
      pageBuilder: (context, state) => const NoTransitionPage(child: EditTextScreen()),
    ),
    GoRoute(
      path: "/content/editBackground",
      pageBuilder: (context, state) => const NoTransitionPage(child: EditBackgroundScreen()),
    ),
    GoRoute(
      path: "/content/sendDevice",
      pageBuilder: (context, state) => const NoTransitionPage(child: SendContentScreen()),
    ) 
  ]
);
