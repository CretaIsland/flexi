// import 'dart:async';

// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:socket_io/socket_io.dart' as socketIOServer;

// import '../../../common/constants/config.dart';

// part 'socket_controller.g.dart';



// @riverpod
// class SocketIOServer extends _$SocketIOServer {

//   late StreamController<String> _streamController;
//   late socketIOServer.Server _server;


//   @override
//   void build() {
//     ref.onDispose(() {
//       print("<<<<<<< SocketIOServerProvider dispose <<<<<<<");
//       _server.close();
//       _streamController.close();
//     });
//     print(">>>>>>> SocketIOServerProvider build >>>>>>");
//     _streamController = StreamController<String>();
//     _server = socketIOServer.Server();
//     _initialize();
//   }

//   void _initialize() async {
//     _server.on("connection", (client) {
//       client.on("message", (data) {
//         print("receive data >>> $data");
//         _streamController.add(data);
//       });
//       client.on("disconnect", (_) {
//         print("client disconnect");
//       });
//     });
//     _server.listen(Config.socketIOPort);
//   }

//   void sendData(String type, String data) {
//     _server.emit(type, data);
//   }

// }
