import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crypto/crypto.dart';

import '../../../core/constants/firebase_options.dart';
import '../model/user_model.dart';
import '../repository/account_repository.dart';

part 'user_controller.g.dart';



@Riverpod(keepAlive: true)
class UserController extends _$UserController {

  late FirebaseFirestore _firestore;
  late AccountRepository _repository;
  late GoogleSignIn _googleSignIn;

  UserModel? build() {
    ref.onDispose(() {
      print('UserController Dispose');
    });
    print('UserController Build');
    return null;
  }

  Future<void> initialize() async {
    _firestore = FirebaseFirestore.instanceFor(app: await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
    _repository = AccountRepository();
    _googleSignIn = GoogleSignIn();
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    try {
      CollectionReference reference = _firestore.collection('hycop_users');
      Query<Object?> query = reference.where('email', isEqualTo: email);

      var result = await query.get().then((data) {
        return data.docs.map((doc) {
          return doc.data()! as Map<String, dynamic>;
        }).toList();
      });

      if(result.isNotEmpty) return result.first;
    } catch (error) {
      print('Error at UserController.getUser >>> $error');
    }
    return null;
  }

  Future<UserModel?> getUserProeprty(String parentMid) async {
    try {
      CollectionReference reference = _firestore.collection('creta_user_property');
      Query<Object?> query = reference.where('parentMid', isEqualTo: parentMid);

      var result = await query.get().then((data) {
        return data.docs.map((doc) {
          return doc.data()! as Map<String, dynamic>;
        }).toList();
      });

      if(result.isNotEmpty) return UserModel.fromJson(result.first);
    } catch (error) {
      print('Error at UserController.getUserProeprty >>> $error');
    }
    return null;
  }

  Future<bool> loginByEmail(String email, String password) async {
    try {
      var user = await getUser(email);
      if(user == null) return false;

      String encryptPassword = sha1.convert(utf8.encode(password)).toString();
      if(encryptPassword == user['password']) {
        var userProperty = await getUserProeprty(user['userId']);
        if(userProperty != null) {
          await _repository.save({
            'email': email,
            'password': password,
            'type': user['accountSignUpType'],
            'mId': user['userId']
          });
          state = userProperty;
          return true;
        }
      }
    } catch (error) {
      print('Error at UserController.loginByEmail >>> $error');
    }
    return false;
  }

  Future<bool> loginByGoogle() async {
    try {
      var account = await _googleSignIn.signIn();
      if(account == null) return false;

      var user = await getUser(account.email);
      if(user != null && user['accountSignUpType'] == 2) {
        var userProperty = await getUserProeprty(user['userId']);
        if(userProperty != null) {
          await _repository.save({
            'email': account.email,
            'password': user['password'],
            'type': user['accountSignUpType'],
            'mId': user['userId']
          });
          state = userProperty;
          return true;
        }
      }
    } catch (error) {
      print('Error at UserController.loginByGoogle >>> $error');
    }
    return false;
  }

  Future<void> logout() async {
    try {
      await _repository.delete();
      if(await _googleSignIn.isSignedIn()) await _googleSignIn.signOut();
      state = null;
    } catch (error) {
      print('Error at UserController.logout >>> $error');
    }
  }

  Future<bool> autoLogin() async {
    try {
      var account = await _repository.get();
      if(account == null) return false;

      if(account['type'] == 1) {
        return await loginByEmail(account['email'], account['password']);
      } else {
        var userProperty = await getUserProeprty(account['mId']);
        if(await _googleSignIn.isSignedIn() && userProperty != null) {
          state = userProperty;
          return true;
        }
      }
    } catch (error) {
      print('Error at UserController.autoLogin >>> $error');
    }
    return false;
  }

}