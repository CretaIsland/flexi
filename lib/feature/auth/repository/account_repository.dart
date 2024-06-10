import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';



class AccountRepository {

  final _accountStore = stringMapStoreFactory.store('account');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;


  Future<void> create(String email, String password) async {
    try {
      _accountStore.add(await _dbClient, {'email': email, 'password': password});
    } catch (error) {
      print('error at AccountRepository.create >>> $error');
    }
  }

  Future<Map<String, String>?> get() async {
    try {
      var result = await _accountStore.find(await _dbClient);
      return result.first.value.cast<String, String>().map((key, value) => MapEntry(key, value));
    } catch (error) {
      print('error at AccountRepository.get >>> $error');
    }
    return null;
  }

  Future<void> delete() async{
    try {
      await _accountStore.delete(await _dbClient);
    } catch (error) {
      print('error at AccountRepository.delete >>> $error');
    }
  }

}