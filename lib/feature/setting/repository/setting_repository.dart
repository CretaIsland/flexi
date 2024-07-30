import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';



class SettingRepository {

  final _store = stringMapStoreFactory.store('setting');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  // ********** Account **********
  Future<void> saveAccount(String email, String password, int type, String mId) async {
    try {
      await _store.record('account').put(await _dbClient, {
        'email': email,
        'password': password,
        'type': type,
        'mId': mId
      });
    } catch (error) {
      print('error at AccountRepository.saveAccount >>> $error');
    }
  }

  Future<Map<String, dynamic>?> getAccount() async {
    try {
      return await _store.record('account').get(await _dbClient);
    } catch (error) {
      print('error at AccountRepository.getAccount >>> $error');
    }
    return null;
  }

  Future<void> deleteAccount() async {
    try {
      await _store.record('account').delete(await _dbClient);
    } catch (error) {
      print('error at AccountRepository.deleteAccount >>> $error');
    }
  }


  // ********** Setting **********
  Future<void> saveAppConfig(Map<String, dynamic> config) async {
    try {
      await _store.record('appConfig').put(await _dbClient, config);
    } catch (error) {
      print('error at AccountRepository.saveAppConfig >>> $error');
    }
  }

  Future<Map<String, dynamic>?> getAppConfig() async {
    try {
      return await _store.record('appConfig').get(await _dbClient);
    } catch (error) {
      print('error at AccountRepository.getAppConfig >>> $error');
    }
    return null;
  }

}