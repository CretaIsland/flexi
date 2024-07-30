import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../constants/config.dart';

part 'socket_client_controller.g.dart';



@riverpod
class SocketClientController extends _$SocketClientController {

  late IO.Socket _socket;


  @override
  void build() {
    ref.onDispose(() {
      print('SocketClientController Dispose!!!');
      _socket.close();
      _socket.disconnect();
      _socket.dispose();
    });
    print('SocketClientController Build!!!');
    _socket = IO.io('',
    IO.OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .setTimeout(10000)
      .build()
    );
  }


  Future<bool> connect(String ip) async {
    final completer = Completer<bool>();

    try {
      if(_socket.io.uri == 'http://$ip:${NetworkConfig.socketIOPort}' && _socket.connected) {
        print('already connected');
        completer.complete(true);
      }
      
      _socket.io.uri = 'http://$ip:${NetworkConfig.socketIOPort}';

      _socket.onConnect((event) {
        if(!completer.isCompleted) {
          completer.complete(true);
        }
      });
      _socket.onConnectTimeout((event) {
        if(!completer.isCompleted) {
          completer.complete(false);
        }
      });

      _socket.connect();
      return completer.future;
    } catch (error) {
      print('Error at SocketClientController.connect >>> $error');
      return false;
    }
  }

  Future<bool> disconnect() async {
    print('socket disconnect');
    final completer = Completer<bool>();
    completer.future.timeout((const Duration(seconds: 15)), onTimeout: () => false);
    if(_socket.connected) {
      _socket.onDisconnect((event) {
        completer.complete(true);
      });
      
      _socket.disconnect();
      return completer.future;
    } else {
      return false;
    }
  }

  Future<void> sendData(Map<String, dynamic> data) async {
    _socket.emit('message', utf8.encode(jsonEncode(data)));
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> sendFile(File file, String fileName, Map<String, dynamic> data) async {
    final Completer<void> completer = Completer<void>();
    _socket.emit('fileStart', utf8.encode(fileName));

    int total = await file.length();
    int count = 0;
    var openRead = file.openRead();

    openRead.listen((bytes) {
      count += bytes.length;
      _socket.emitWithBinary('file', bytes);
      print('$count/$total');
    }, onDone: () async {
      print('file done');
      await Future.delayed(const Duration(seconds: 5));
      print('fileDone!!!');
      _socket.emit('fileDone');
      String dataStr = jsonEncode(data);
      print(data);
      _socket.emit('message', utf8.encode(dataStr)); 
      await Future.delayed(const Duration(seconds: 1));
      completer.complete();
    });

    return completer.future;
  }

}