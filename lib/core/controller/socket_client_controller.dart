import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../constants/config.dart';

part 'socket_client_controller.g.dart';



@riverpod
class SocketClientController extends _$SocketClientController {

  late socket_io.Socket _socket;

  @override
  void build() {
    print('SocketClientController Build');
    _socket = socket_io.io('', socket_io.OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .setTimeout(15000)
      .build()
    );
  }

  Future<bool> connect(String ip) async {
    try {
      final completer = Completer<bool>();
      String url = 'http://$ip:${NetworkConfig.socketIOPort}';
      if(_socket.io.uri == url && _socket.connected) completer.complete(true);

      _socket.onConnect((event) {
        if(!completer.isCompleted) completer.complete(true);
      });
      _socket.onConnectTimeout((event) {
        if(!completer.isCompleted) completer.complete(false);
      });
      _socket.onConnectError((event) {
        if(!completer.isCompleted) completer.complete(false);
      });

      _socket.io.uri = url;
      _socket.connect();
      return completer.future;
    } catch (error) {
      print('Error at SocketClientController.connect >>> $error');
      return false;
    }
  }

  Future<bool> disconnect() async {
    try {
      final completer = Completer<bool>();
      if(!_socket.connected) completer.complete(true);

      _socket.onDisconnect((event) {
        if(!completer.isCompleted) completer.complete(true);
      });

      _socket.disconnect();
      return completer.future;
    } catch (error) {
      print('Error at SocketClientController.disconnect >>> $error');
      return false;
    }
  }

  Future<void> sendData(Map<String, dynamic> data) async {
    try {
      _socket.emit('message', utf8.encode(jsonEncode(data)));
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (error) {
      print('Error at SocketClientController.sendData >>> $error');
    }
  }

  Future<void> sendFile(String fileName, File file) async {
    try {
      final completer = Completer<void>();
      _socket.emit('message', utf8.encode(jsonEncode({'command': 'fileReady'})));
      print('ready');
      _socket.emit('fileStart', utf8.encode(fileName));
      print('start');

      int total = await file.length();
      int count = 0;
      var openRead = file.openRead();

      openRead.listen((bytes) {
        count += bytes.length;
        _socket.emitWithBinary('file', bytes);
        print('$count/$total');
      }, onDone: () {
        _socket.emit('fileDone');
        print('done');
        completer.complete();
      });

      await completer.future;
    } catch (error) {
      print('Error at SocketClientController.sendFile >>> $error');
    }
  }

}