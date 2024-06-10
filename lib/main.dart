import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'feature/auth/repository/account_repository.dart';
import 'firebase_options.dart';
import 'router.dart';



late TextScaler textScaler;
bool isLogin = false;


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initialize();
  runApp(const ProviderScope(child: FlexiApp()));
}

Future<void> initialize() async {
  Map<String, String>? saveAccount = await AccountRepository().get();
  if(saveAccount != null) {
    print(saveAccount['email']);
    print(saveAccount['password']);

    var fbApp = FirebaseFirestore.instanceFor(app: await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
    CollectionReference collectionRef = fbApp.collection('hycop_users');
    Query<Object?> query = collectionRef.orderBy('name', descending: true);
    saveAccount.map((mid, value) {
      query = query.where(mid, isEqualTo: value);
      return MapEntry(mid, value);
    });

    var result = await query.get().then((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data()! as Map<String, dynamic>;
      }).toList();
    });

    if(result.isNotEmpty) isLogin = true;
  }

  FlutterNativeSplash.remove();
}


class FlexiApp extends StatelessWidget {
  const FlexiApp({super.key});

  @override
  Widget build(BuildContext context) {
    textScaler = MediaQuery.of(context).textScaler;

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }

}