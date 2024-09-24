import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/firebase_options.dart';
import '../model/user_model.dart';
import '../repository/account_repository.dart';

part 'user_controller.g.dart';



@Riverpod(keepAlive: true)
class UserController extends _$UserController {

  late FirebaseFirestore _firestore;
  late AccountRepository _repository;

  @override
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

  Future<UserModel?> getUserProperty(String parentMid) async {
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
      print('Error at UserController.getUserProperty >>> $error');
    }
    return null;
  }

  Future<bool> loginByEmail(String email, String password) async {
    try {
      var user = await getUser(email);
      if(user == null) return false;

      String encryptPassword = sha1.convert(utf8.encode(password)).toString();
      if(encryptPassword == user['password']) {
        var userProperty = await getUserProperty(user['userId']);
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

  Future<void> logout() async {
    try {
      await _repository.delete();
      state = null;
    } catch (error) {
      print('Error at UserController.logout >>> $error');
    }
  }

  Future<bool> autoLogin() async {
    try {
      var account = await _repository.get();
      if(account == null) return false;

      return await loginByEmail(account['email'], account['password']);
    } catch (error) {
      print('Error at UserController.autoLogin >>> $error');
    }
    return false;
  }

}