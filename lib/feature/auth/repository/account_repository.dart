import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';



class AccountRepository {

  final _store = intMapStoreFactory.store('account');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  Future<void> create(String email, String password, int signType, String mId) async {
    try {
      await _store.record(0).put(await _dbClient, {
        'email': email,
        'password': password,
        'signType': signType,
        'mId': mId
      });
    } catch (error) {
      print('error at AccountRepository.create >>> $error');
    }
  }

  Future<Map<String, dynamic>?> get() async {
    try {
      return await _store.record(0).get(await _dbClient);
    } catch (error) {
      print('error at AccountRepository.get >>> $error');
    }
    return null;
  }

  Future<void> delete() async {
    try {
      await _store.record(0).delete(await _dbClient);
    } catch (error) {
      print('error at AccountRepository.delete >>> $error');
    }
  }

}