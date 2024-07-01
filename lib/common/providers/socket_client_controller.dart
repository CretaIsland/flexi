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
  bool _isConnected = false;

  bool isConnected() => _isConnected;


  void build() {
    ref.onDispose(() {
      print('SocketClientController Dispose!!!');
      _socket.close();
      _socket.disconnect();
      _socket.dispose();
    });
    print('SocketClientController Build!!!');
  }


  Future<bool> connect(String ip) async {
    try {
      final completer = Completer<bool>();
      _socket = IO.io(
        'http://$ip:${NetworkConfig.socketIOPort}',
        IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build()
      );

      _socket.onConnect((data) {
        _isConnected = true;
        completer.complete(_isConnected);
        print('socket client connect');
      });
      _socket.onDisconnect((data) {
        print('socket client disconnect');
      });

      _socket.connect();

      // timeout 10초
      Future.delayed(const Duration(seconds: 10), () {
        completer.complete(_isConnected);
      });
      return completer.future;
    } catch (error) {
      print('error at SocketClientController.connect >>> $error');
    }
    return false;
  }

  void sendData(Map<String, dynamic> data) {
    _socket.emit('message', utf8.encode(jsonEncode(data)));
  }

  void sendFile(File file, String fileName, Map<String, dynamic> data) async {
    _socket.emit('fileStart', utf8.encode(fileName));
    int total = await file.length();
    int count = 0;
    var fileOpenRead = file.openRead();
    fileOpenRead.listen(
      (bytes) {
        count += bytes.length;
        _socket.emitWithBinary('file', bytes);
        print('$count/$total');
      },
      onDone: () {
        _socket.emit('fileDone');
        _socket.emit('message', utf8.encode(jsonEncode(data)));
      }
    );
  }

}