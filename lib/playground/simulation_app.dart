import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:developer' as developer;

import '../common/providers/network_providers.dart';

part 'simulation_app.freezed.dart';
part 'simulation_app.g.dart';

@freezed
class Command with _$Command {
  const factory Command.playerStatus({
    required String command,
    required String deviceId,
    String? connectionMode,
    String? ip,
    bool? isRegistered,
    bool? hasContent,
  }) = _PlayerStatus;

  const factory Command.register({
    required String command,
    required String deviceId,
    String? ssid,
    String? password,
  }) = _Register;

  const factory Command.unRegister({
    required String command,
    required String deviceId,
  }) = _UnRegister;

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);
}

class SimulationApp extends ConsumerStatefulWidget {
  const SimulationApp({super.key});

  @override
  ConsumerState<SimulationApp> createState() => _SimulationAppState();
}

class _SimulationAppState extends ConsumerState<SimulationApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HotspotModeScreen(),
                    ));
              },
              child: const Text('hotspot mode')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WifiModeScreen(),
                    ));
              },
              child: const Text('wifi mode')),
        ],
      ),
    );
  }
}

class HotspotModeScreen extends ConsumerStatefulWidget {
  const HotspotModeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HotspotModeScreenState();
}

class _HotspotModeScreenState extends ConsumerState<HotspotModeScreen> {
  @override
  void initState() {
    developer.log('HotspotModeScreen initState');
    super.initState();
  }

  @override
  void dispose() {
    developer.log('HotspotModeScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(uDPMulticastProvider, (prev, next) {
      String? str = next.value;
      if (str != null) {
        //developer.log('str:$str');
        final json = jsonDecode(str);
        //developer.log('json:$json');

        final Command command = Command.fromJson(json);

        command.map(
          playerStatus: (value) {
            developer.log('${value.ip}');
          },
          register: (_) {},
          unRegister: (_) {},
        );
        developer.log('command:$command');
      }
    });
    ref.listen(socketIOClientProvider(ip: '192.169.1.10', port: 9999),
        (prev, next) {});
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotspot Mode'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                ref
                    .read(socketIOClientProvider(ip: '192.169.1.10', port: 9999)
                        .notifier)
                    .sendData('''
{
  "runtimeType":"register",
  "command":"register",
  "deviceId":"DBAP0001",
  "ssid":"SQI-Support_2G",
  "password":"sqisoft74307"
}
''');
              },
              child: const Text('save register')),
          ElevatedButton(
              onPressed: () {
                ref
                    .read(socketIOClientProvider(ip: '192.169.1.10', port: 9999)
                        .notifier)
                    .sendData('''
{
  "runtimeType":"unRegister",
  "command":"unRegister",
  "deviceId":"DBAP0001",
  "ssid":"SQI-Support_2G",
  "password":"sqisoft74307"
}
''');
              },
              child: const Text('delete register')),
        ],
      ),
    );
  }
}

class WifiModeScreen extends ConsumerStatefulWidget {
  const WifiModeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WifiModeScreenState();
}

class _WifiModeScreenState extends ConsumerState<WifiModeScreen> {
  @override
  void initState() {
    developer.log('WifiModeScreen initState');
    super.initState();
  }

  @override
  void dispose() {
    developer.log('WifiModeScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wifi Mode'),
      ),
    );
  }
}
