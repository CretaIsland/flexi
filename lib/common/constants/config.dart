import 'dart:io';

class Config {
  static int udpMulticastPort = 4545;
  static InternetAddress udpMulticastAddress = InternetAddress('224.0.0.251');
  static int socketIOPort = 9999;
}
