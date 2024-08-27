import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/firebase_options.dart';
import '../model/user_model.dart';
import '../repository/setting_repository.dart';

part 'auth_controller.g.dart';



@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {

  late FirebaseFirestore _firestore;
  final SettingRepository _settingRepository = SettingRepository();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  UserModel? build() {
    ref.onDispose(() {
      print('AuthController Dispose!!!');
    });
    print('AuthController Build!!!');
    return null;
  }


  // firebase initialize
  Future<void> initialize() async {
    _firestore = FirebaseFirestore.instanceFor(app: await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
  }

  // auto login
  Future<bool> autoLogin() async {
    try {
      var saveAccount = await _settingRepository.getAccount();
      if(saveAccount == null) return false;

      if(saveAccount['type'] == 1) {
        var accountData = await getAccountData(saveAccount['email']);
        if(accountData == null) return false;
        if(saveAccount['password'] == accountData['password']) {
          state = await getUserData(saveAccount['mId']);
          return true;
        }
      } else {
        if(await _googleSignIn.isSignedIn()) {
          state = await getUserData(saveAccount['mId']);
          return true;
        }
      }
    } catch (error) {
      print('Error at AuthController.autoLogin >>> $error');
    }
    return false;
  }

  // email login
  Future<bool> loginByEmail(String email, String password) async {
    try {
      var accountData = await getAccountData(email);
      if(accountData == null) return false;

      String encryptPassword = sha1.convert(utf8.encode(password)).toString();;
      if(encryptPassword == accountData['password']) {
        await _settingRepository.saveAccount(
          email, 
          encryptPassword, 
          accountData['accountSignUpType'], 
          accountData['userId']
        );
        state = await getUserData(accountData['userId']);
        return true;
      }
    } catch (error) {
      print('Error at AuthController.loginByEmail >>> $error');
    }
    return false;
  }

  // google login
  Future<bool> loginByGoogle() async {
    try {
      var googleAccount = await _googleSignIn.signIn();
      if(googleAccount == null) return false;

      var accountData = await getAccountData(googleAccount.email);
      if(accountData != null && accountData['accountSignUpType'] == 2) {
        await _settingRepository.saveAccount(
          googleAccount.email, 
          accountData['password'], 
          accountData['accountSignUpType'], 
          accountData['userId']
        );
        state = await getUserData(accountData['userId']);
        return true;
      }
    } catch (error) {
      print('Error at AuthController.loginByGoogle >>> $error');
    }
    return false;
  }

  // logout
  Future<void> logout() async {
    try {
      state = null;
      await _settingRepository.deleteAccount();
      if(await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
    } catch (error) {
      print('Error at AuthController.logout >>> $error');
    }
  }

  // get account data
  Future<Map<String, dynamic>?> getAccountData(String email) async {
    try {
      CollectionReference collectionRef = _firestore.collection('hycop_users');
      Query<Object?> query = collectionRef.where('email', isEqualTo: email);

      var result = await query.get().then((data) {
        return data.docs.map((doc) {
          return doc.data()! as Map<String, dynamic>;
        }).toList();
      });

      if(result.isNotEmpty) return result.first;
    } catch (error) {
      print('Error at AuthController.getAccountData >>> $error');
    }
    return null;
  }

  // get user data
  Future<UserModel?> getUserData(String mId) async {
    try {
      CollectionReference collectionRef = _firestore.collection('creta_user_property');
      Query<Object?> query = collectionRef.where('parentMid', isEqualTo: mId);
      var result = await query.get().then((data) {
        return data.docs.map((doc) {
          return doc.data()! as Map<String ,dynamic>;
        }).toList();
      });

      if(result.isNotEmpty) return UserModel.fromJson(result.first);
    } catch (error) {
      print('Error at AuthController.getUserData >>> $error');
    }
    return null;
  }

} 