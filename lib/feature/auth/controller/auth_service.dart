import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../common/constants/firebase_options.dart';
import '../../../utils/flexi_utils.dart';
import '../model/user_info.dart';
import '../repository/account_repository.dart';



UserInfo? currentUser;

class AuthController {

  late FirebaseFirestore _firestore;
  late AccountRepository _accountRepository;
  late GoogleSignIn _googleSignIn;


  Future<void> initialize() async {
    _firestore = FirebaseFirestore.instanceFor(app: await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
    _accountRepository = AccountRepository();
    _googleSignIn = GoogleSignIn();
  }

  Future<Map<String, dynamic>?> isExistAccount(String email) async {
    try {
      CollectionReference collectionRef = _firestore.collection('hycop_users');
      Query<Object?> query = collectionRef.orderBy('email', descending: true);
      Map<String, String> emailQuery = {'email': email};
      emailQuery.map((mid, value) {
        query = query.where(mid, isEqualTo: value);
        return MapEntry(mid, value);
      });

      var users = await query.get().then((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.data()! as Map<String, dynamic>;
        }).toList();
      });
      if(users.isNotEmpty) return users.first;
    } catch (error) {
      print('error at AuthController.isExistAccount >>> $error');
    }
    return null;
  }

  Future<UserInfo?> getUserInfo(String mId) async {
    try {
      CollectionReference collectionRef = _firestore.collection('creta_user_property');
      Query<Object?> query = collectionRef.orderBy('parentMid', descending: true);
      Map<String, String> parentMidQuery = {'parentMid': mId};
      parentMidQuery.map((mid, value) {
        query = query.where(mid, isEqualTo: value);
        return MapEntry(mid, value);
      });

      var userInfo = await query.get().then((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.data()! as Map<String, dynamic>;
        }).toList();
      });
      if(userInfo.isNotEmpty) return UserInfo.fromJson(userInfo.first);
    } catch (error) {
      print('error at AuthController.getUserInfo >>> $error');
    }
    return null;
  }

  Future<void> autoLogin() async {
    try {
      var saveAccount = await _accountRepository.get();
      if(saveAccount == null) return;

      var accountInfo = await isExistAccount(saveAccount['email']);
      if(accountInfo == null) return;

      if(saveAccount['signType'] == 1) {
        if(accountInfo['password'] == saveAccount['password']) currentUser = await getUserInfo(saveAccount['mId']);
      } else {
        if(await _googleSignIn.isSignedIn()) currentUser = await getUserInfo(saveAccount['mId']);
      }
    } catch (error) {
      print('error at AuthController.autoLogin >>> $error');
    }
  }

  Future<void> loginByEmail(String email, String password) async {
    try {
      Map<String, dynamic>? accountInfo = await isExistAccount(email);
      if(accountInfo == null) return;

      String encryptPassword = FlexiUtils.stringToSha1(password);
      if(encryptPassword == accountInfo['password']) {
        await _accountRepository.delete();
        await _accountRepository.create(
          email, 
          encryptPassword, 
          accountInfo['accountSignUpType'],
          accountInfo['userId']
        );
        currentUser = await getUserInfo(accountInfo['userId']);
      }
    } catch (error) {
      print('error at AuthController.loginByEmail >>> $error');
    }
  }

  Future<void> loginByGoogle() async {
    try {
      var account = await _googleSignIn.signIn();
      if(account == null) return;

      var accountInfo = await isExistAccount(account.email);
      if(accountInfo != null && accountInfo['accountSignUpType'] == 2) {
        await _accountRepository.delete();
        await _accountRepository.create(
          account.email, 
          accountInfo['password'], 
          accountInfo['accountSignUpType'],
          accountInfo['userId']
        );
        currentUser = await getUserInfo(accountInfo['userId']);
      }
    } catch (error) {
      print('error at AuthController.loginByGoogle >>> $error');
    }
  }

  Future<void> logout() async {
    try {
      await _accountRepository.delete();
      currentUser = null;
    } catch (error) {
      print('error at AuthController.logout >>> $error');
    }
  }

}