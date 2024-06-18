import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../firebase_options.dart';
import '../../../main.dart';
import '../../../utils/flexi_utils.dart';
import '../model/user_info.dart';
import '../repository/account_repository.dart';


class AuthService {

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
      print('error at AuthService.isExistAccount >>> $error');
    }
    return null;
  }

  Future<bool> loginByEmail(String email, String password) async {
    try {
      Map<String, dynamic>? account = await isExistAccount(email);
      if(account == null) return false;

      String encryptPassword = FlexiUtils.stringToSha1(password);
      if(encryptPassword == account['password']) {
        await _accountRepository.delete();
        await _accountRepository.create(email, encryptPassword, account['accountSignUpType'].toString(), account['userId']);
        return true;
      }
    } catch (error) {
      print('error at AuthService.loginByEmail >>> $error');
    }
    return false;
  }

  Future<bool> loginByGoogle() async {
    try {
      if(await _googleSignIn.isSignedIn()) return true;
      var account = await _googleSignIn.signIn();
      if(account == null) return false;
      var accountInfo = await isExistAccount(account.email);
      if(accountInfo != null && accountInfo['accountSignUpType'] == 2) {
        await _accountRepository.delete();
        await _accountRepository.create(
          accountInfo['email'], 
          accountInfo['password'], 
          accountInfo['accountSignUpType'].toString(), 
          accountInfo['userId']
        );
        return true;
      }
      await _googleSignIn.signOut();
    } catch (error) {
      print('error at AuthService.loginByGoogle >>> $error');
    }
    return false;
  } 

  Future<bool> autoLogin() async {
    try {
      var account = await _accountRepository.get();
      if(account == null) return false;

      print("저장된 계정 >>>>> $account");
      var accountInfo = await isExistAccount(account['email']!);
      if(accountInfo == null) return false;

      if(accountInfo['accountSignUpType'] == 1) {
        if(accountInfo['password'] == account['password']) return true;
      } else {
        if(await _googleSignIn.isSignedIn()) return true;
      }
    } catch (error) {
      print('error at AuthService.autoLogin >>> $error');
    }
    return false;
  }

  Future<UserInfo?> getUserInfo(String userId) async {
    try {
      CollectionReference collectionRef = _firestore.collection('creta_user_property');
      Query<Object?> query = collectionRef.orderBy('email', descending: true);
      query.where('parentMid', isEqualTo: userId);
      var userInfos = await query.get().then((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.data()! as Map<String, dynamic>;
        }).toList();
      });
      
      if(userInfos.isNotEmpty) return UserInfo(email: userInfos.first['email'], nickname: userInfos.first['nickname']);
    } catch (error) {
      print('error at AuthService.getUserInfo >>> $error');
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _accountRepository.delete();
      if(await _googleSignIn.isSignedIn()) await _googleSignIn.signOut();
      print(await _googleSignIn.isSignedIn());
    } catch (error) {
      print('error at AuthService.logout >>> $error');
    }
  }

}