import 'package:sembast/sembast.dart';

import '../../database/app_database.dart';



class SettingRepository {

  final _store = stringMapStoreFactory.store('setting');
  Future<Database> get _dbClient async => await AppDatabase.instance.database;

  Future<void> save(Map<String, dynamic> setting) async {
    try {
      await _store.record('appSetting').put(await _dbClient, setting);
    } catch (error) {
      print('Error at SettingRepository.save >>> $error');
    }
  }

  Future<Map<String, dynamic>?> get() async {
    try {
      return await _store.record('appSetting').get(await _dbClient);
    } catch (error) {
      print('Error at SettingRepository.get >>> $error');
    }
    return null;
  }

}