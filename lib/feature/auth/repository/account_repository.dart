import 'package:sembast/sembast.dart';
import '../../database/app_database.dart';



class AccountRepository {

  final _store = stringMapStoreFactory.store('setting');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;

  Future<void> save(Map<String, dynamic> data) async {
    try {
      await _store.record('account').put(await _dbClient, data);
    } catch (error) {
      print('Error at AccountRepository.save >>> $error');
    }
  }

  Future<Map<String, dynamic>?> get() async {
    try {
      return await _store.record('account').get(await _dbClient);
    } catch (error) {
      print('Error at AccountRepository.save >>> $error');
    }
    return null;
  }

  Future<void> delete() async {
    try {
      await _store.record('account').delete(await _dbClient);
    } catch (error) {
      print('Error at AccountRepository.delete >>> $error');
    }
  }

}