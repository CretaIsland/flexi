import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'feature/auth/controller/auth_service.dart';
import 'view/content/screen/background_edit_screen.dart';
import 'view/content/screen/content_info_screen.dart';
import 'view/content/screen/content_list_screen.dart';
import 'view/content/screen/content_send_screen.dart';
import 'view/content/screen/text_edit_screen.dart';
import 'view/device/screen/device_info_screen.dart';
import 'view/device/screen/device_list_screen.dart';
import 'view/device/screen/qrcode_load_screen.dart';
import 'view/device/screen/qrcode_scan_screen.dart';
import 'view/device/screen/timezone_set_screen.dart';
import 'view/device/screen/wifi_set_screen.dart';
import 'view/home_screen.dart';
import 'view/login_screen.dart';
import 'view/setting/screen/account_info_screen.dart';
import 'view/setting/screen/app_info_screen.dart';
import 'view/setting/screen/app_option_screen.dart';
import 'view/setting/screen/device_recovery_screen.dart';
import 'view/setting/screen/settings_screen.dart';



final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: rootNavKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        if(currentUser != null) {
          return '/device/list';
        }
        return '/login';
      },
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
          pageBuilder: (context, state) => NoTransitionPage(child: TimezoneSetScreen()),
        ),
        GoRoute(
          path: '/device/setWifi',
          pageBuilder: (context, state) => NoTransitionPage(child: WifiSetScreen(rootContext: context)),
        ),
        // // ********** Content **********
        GoRoute(
          path: '/content/list',
          pageBuilder: (context, state) => NoTransitionPage(child: ContentListScreen(rootContext: context)),
        ),
        GoRoute(
          path: '/content/info',
          pageBuilder: (context, state) => const NoTransitionPage(child: ContentInfoScreen()),
        ),
        // // ********** Settings **********
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => const NoTransitionPage(child: SettingsScreen()),
        ),
        GoRoute(
          path: '/settings/account',
          pageBuilder: (context, state) => const NoTransitionPage(child: AccountInfoScreen()),
        ),
        GoRoute(
          path: '/settings/app/info',
          pageBuilder: (context, state) => const NoTransitionPage(child: AppInfoScreen()),
        ),
        GoRoute(
          path: '/settings/app/option',
          pageBuilder: (context, state) => const NoTransitionPage(child: AppOptionScreen()),
        ),
        GoRoute(
          path: '/settings/deviceRecovery',
          pageBuilder: (context, state) => const NoTransitionPage(child: DeviceRecoveryScreen()),
        ),
      ]
    ),
    // ********** QR Code **********
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
      pageBuilder: (context, state) => const NoTransitionPage(child: ContentSendScreen()),
    ),
  ]
);