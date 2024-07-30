import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../common/constants/firebase_options.dart';
import '../../../util/utils.dart';
import '../model/user_model.dart';
import '../repository/setting_repository.dart';



final loginUser = StateProvider<UserModel?>((ref) => null);

class UserController {

  late FirebaseFirestore _firestore;
  final SettingRepository _settingRepository = SettingRepository();
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  Future<void> initialize() async {
    _firestore = FirebaseFirestore.instanceFor(app: await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
  }


  Future<UserModel?> getUserData(String mId) async {
    try {
      CollectionReference collectionRef = _firestore.collection('creta_user_property');
      Query<Object?> query = collectionRef.where('parentMid', isEqualTo: mId).orderBy('parentMid', descending: true);

      var results = await query.get().then((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.data()! as Map<String, dynamic>;
        }).toList();
      });
      
      if(results.isNotEmpty) return UserModel.fromJson(results.first);
    } catch (error) {
      print('error at UserController.getUserData >>> $error');
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    try {
      CollectionReference collectionRef = _firestore.collection('hycop_users');
      Query<Object?> query = collectionRef.where('email', isEqualTo: email).orderBy('email', descending: true);

      var results = await query.get().then((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.data()! as Map<String, dynamic>;
        }).toList();
      });

      if(results.isNotEmpty) return results.first;
    } catch (error) {
      print('error at UserController.getUser >>> $error');
    }
    return null;
  }

  Future<UserModel?> loginByEmail(String email, String password) async {
    try {
      var user = await getUser(email);
      if(user == null) return null;

      String encryptPassword = FlexiUtils.stringToSha1(password);
      if(encryptPassword == user['password']) {
        await _settingRepository.saveAccount(
          email, 
          encryptPassword, 
          user['accountSignUpType'],
          user['userId']
        );
        return await getUserData(user['userId']);
      }
    } catch (error) {
      print('error at UserController.loginByEmail >>> $error');
    }
    return null;
  }

  Future<UserModel?> loginByGoogle() async {
    try {
      var account = await _googleSignIn.signIn();
      if(account == null) return null;

      var user = await getUser(account.email);
      if(user != null && user['accountSignUpType'] == 2) {
        await _settingRepository.saveAccount(
          account.email, 
          user['password'], 
          user['accountSignUpType'],
          user['userId']
        );
        return await getUserData(user['userId']);
      }
    } catch (error) {
      print('error at UserController.loginByGoogle >>> $error');
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _settingRepository.deleteAccount();
    } catch (error) {
      print('error at UserController.logout >>> $error');
    }
  }

  Future<UserModel?> autoLogin() async {
    try {
      var saveAccount = await _settingRepository.getAccount();
      print(saveAccount);
      if(saveAccount == null) return null;

      if(saveAccount['type'] == 1) {
        var user = await getUser(saveAccount['email']);
        if(user == null) return null;
        if(user['password'] == saveAccount['password']) return await getUserData(saveAccount['mId']);
      } else {
        if(await _googleSignIn.isSignedIn()) return await getUserData(saveAccount['mId']);
      }
    } catch (error) {
      print('error at UserController.autoLogin >>> $error');
    }
    return null;
  }

}