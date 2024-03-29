import 'package:hycop_light/hycop.dart';

// ignore: must_be_immutable
class HostModel extends AbsExModel {
  String hostName = '';
  String ip = '';
  String interfaceName = '';
  bool isConnected = false;

  HostModel({
    super.type = ExModelType.host,
    super.parent = 'local',
    this.hostName = '',
    this.interfaceName = '',
    this.ip = '',
    this.isConnected = false,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        hostName,
        interfaceName,
        ip,
        isConnected,
      ];

  @override
  void copyFrom(AbsExModel src, {String? newMid, String? pMid}) {
    super.copyFrom(src, newMid: newMid, pMid: pMid);
    HostModel srcHost = src as HostModel;

    hostName = srcHost.hostName;
    interfaceName = srcHost.interfaceName;
    ip = srcHost.ip;
    isConnected = srcHost.isConnected;
  }

  @override
  void updateFrom(AbsExModel src) {
    super.updateFrom(src);
    HostModel srcHost = src as HostModel;
    hostName = srcHost.hostName;
    interfaceName = srcHost.interfaceName;
    ip = srcHost.ip;
    isConnected = srcHost.isConnected;
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    //super.fromMap(map);
    hostName = map["hostName"] ?? '';
    interfaceName = map["interfaceName"] ?? '';
    ip = map["ip"] ?? '';
    isConnected = map["isConnected"] ?? false;
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addEntries({
        "hostName": hostName,
        "interfaceName": interfaceName,
        "ip": ip,
        "isConnected": isConnected,
      }.entries);
  }
}
