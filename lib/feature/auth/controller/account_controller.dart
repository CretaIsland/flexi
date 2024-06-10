import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase_options.dart';
import '../repository/account_repository.dart';

part 'account_controller.g.dart';


@riverpod
class AccountController extends _$AccountController {


  late AccountRepository _accountRepository;
  late FirebaseFirestore _firestore;


  @override
  Future<void> build() async {
    _accountRepository = AccountRepository();
    _firestore = FirebaseFirestore.instanceFor(app: await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    ));
  }

  Future<bool> login(Map<String, String> accountInfo) async {
    try {
      CollectionReference collectionRef = _firestore.collection('hycop_users');
      Query<Object?> query = collectionRef.orderBy('name', descending: true);
      accountInfo.map((mid, value) {
        query = query.where(mid, isEqualTo: value);
        return MapEntry(mid, value);
      });

      var result = await query.get().then((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.data()! as Map<String, dynamic>;
        }).toList();
      });

      if(result.isNotEmpty) {
        print(result.first);
        await _accountRepository.delete();
        await _accountRepository.create(accountInfo['email']!, accountInfo['password']!);
        return true;
      }
    } catch (error) {
      print('error at AccountController.login >>> $error');
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      await _accountRepository.delete();
    } catch (error) {
      print('error at AccountController.logout');
    }
    return false;
  }

  Future<Map<String, String>?> getSaveAccount() async {
    return await _accountRepository.get();
  }

}