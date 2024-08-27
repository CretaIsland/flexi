import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view/home_screen.dart';
import 'view/content/screen/background_edit_screen.dart';
import 'view/content/screen/content_info_screen.dart';
import 'view/content/screen/content_list_screen.dart';
import 'view/content/screen/content_send_screen.dart';
import 'view/content/screen/text_edit_screen.dart';
import 'view/device/screen/device_info_screen.dart';
import 'view/device/screen/device_list_screen.dart';
import 'view/device/screen/device_register_screen.dart';
import 'view/device/screen/qrcode_load_screen.dart';
import 'view/device/screen/qrcode_scan_screen.dart';
import 'view/device/screen/timezone_set_screen.dart';
import 'view/device/screen/wifi_set_screen.dart';
import 'view/login_screen.dart';
import 'view/setting/screen/account_info_screen.dart';
import 'view/setting/screen/app_setting_screen.dart';
import 'view/setting/screen/app_update_screen.dart';
import 'view/setting/screen/device_recovery_screen.dart';
import 'view/setting/screen/setting_menu_screen.dart';
import 'view/splash_screen.dart';



final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: rootNavKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(child: SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const NoTransitionPage(child: LoginScreen()),
    ),
    ShellRoute(
      navigatorKey: shellNavKey,
      pageBuilder: (context, state, child) => NoTransitionPage(child: HomeScreen(child: child)),
      routes: [ 
        // ********** Device **********
        GoRoute(
          path: '/device/list',
          pageBuilder: (context, state) => NoTransitionPage(child: DeviceListScreen(rootContext: context)),
        ),
        GoRoute(
          path: '/device/info',
          pageBuilder: (context, state) => NoTransitionPage(child: DeviceInfoScreen(rootContext: context)),
        ),
        GoRoute(
          path: '/device/setTimezone',
          pageBuilder: (context, state) => const NoTransitionPage(child: TimezoneSetScreen()),
        ),
        GoRoute(
          path: '/device/setWifi',
          pageBuilder: (context, state) => NoTransitionPage(child: WifiSetScreen(rootContext: context)),
        ),
        GoRoute(
          path: '/device/register',
          pageBuilder: (context, state) => NoTransitionPage(child: DeviceRegisterScreen(rootContext: context)),
        ),
        // ********** Content **********
        GoRoute(
          path: '/content/list',
          pageBuilder: (context, state) => NoTransitionPage(child: ContentListScreen(rootContext: context)),
        ),
        GoRoute(
          path: '/content/info',
          pageBuilder: (context, state) => const NoTransitionPage(child: ContentInfoScreen()),
        ),
        // ********** Setting **********
        GoRoute(
          path: '/setting',
          pageBuilder: (context, state) => const NoTransitionPage(child: SettingMenuScreen()),
        ),
        GoRoute(
          path: '/setting/account',
          pageBuilder: (context, state) => const NoTransitionPage(child: AccountInfoScreen()),
        ),
        GoRoute(
          path: '/setting/appSetting',
          pageBuilder: (context, state) => const NoTransitionPage(child: AppSettingScreen()),
        ),
        GoRoute(
          path: '/setting/appUpdate',
          pageBuilder: (context, state) => const NoTransitionPage(child: AppUpdateScreen()),
        ),
        GoRoute(
          path: '/setting/deviceRecovery',
          pageBuilder: (context, state) => const NoTransitionPage(child: DeviceRecoveryScreen()),
        ),
      ]
    ),
    // ********** Qrcode **********
    GoRoute(
      path: '/qrcode/scan',
      pageBuilder: (context, state) => const NoTransitionPage(child: QrcodeScanScreen()),
    ),
    GoRoute(
      path: '/qrcode/load',
      pageBuilder: (context, state) => const NoTransitionPage(child: QrcodeLoadScreen()),
    ),
    // ********** Edit Content **********
    GoRoute(
      path: '/content/editText',
      pageBuilder: (context, state) => const NoTransitionPage(child: TextEditScreen()),
    ),
    GoRoute(
      path: '/content/editBackground',
      pageBuilder: (context, state) => const NoTransitionPage(child: BackgroundEditScreen()),
    ),
    // ********** Send Content **********
    GoRoute(
      path: '/content/send',
      pageBuilder: (context, state) => NoTransitionPage(child: ContentSendScreen(rootContext: context)),
    ),
  ]
);