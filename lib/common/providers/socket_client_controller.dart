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
    _socket = IO.io('', IO.OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .setTimeout(10000)
      .build()
    );
  }

  Future<bool> connect(String ip) async {
    final completer = Completer<bool>();
    try {
      // already connected
      if(_socket.io.uri == 'http://$ip:${NetworkConfig.socketIOPort}' && _socket.connected) completer.complete(true);

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
    final completer = Completer<bool>();
    completer.future.timeout((const Duration(seconds: 10)), onTimeout: () => false);
    try {
      // already disconnect
      if(!_socket.connected) completer.complete(true);

      _socket.onDisconnect((event) {
        if(!completer.isCompleted) {
          completer.complete(true);
        }
      });

      _socket.disconnect();
      return completer.future;
    } catch (error) {
      print('Error at SocketClientController.disconnect >>> $error');
      return false;
    }
  }

  Future<void> sendData(Map<String, dynamic> data) async {
    _socket.emit('message', utf8.encode(jsonEncode(data)));
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> sendFile(File file, String fileName) async {
    final completer = Completer<void>();
    try {
      _socket.emit('fileStart', utf8.encode(fileName));
      await Future.delayed(const Duration(seconds: 1));
      int total = await file.length();
      int count = 0;
      
      file.openRead().listen((bytes) {
        count += bytes.length;
        _socket.emitWithBinary('file', bytes);
        print('$count/$total');
      }, onDone: () {
        _socket.emit('fileDone');
        completer.complete();
      });

      return completer.future;
    } catch (error) {
      print('Error at SocketClientController.sendFile >>> $error');
    }
  }

}