import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';



class AppDatabase {

  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;
  Completer<Database>? _dbOpenCompleter;

  AppDatabase._();

  Future<Database> get database async {
    if(_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final databasePath = '${appDocumentDir.path}/flexi.db';
    final database = await databaseFactoryIo.openDatabase(databasePath);
    _dbOpenCompleter!.complete(database);
  }

}