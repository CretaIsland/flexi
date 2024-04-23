import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;
import '../common/providers/providers.dart';

class FunctionsApp extends ConsumerStatefulWidget {
  const FunctionsApp({super.key});

  @override
  ConsumerState<FunctionsApp> createState() => _FunctionsAppState();
}

class _FunctionsAppState extends ConsumerState<FunctionsApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Functions - App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //인터넷 연결 여부
            Column(
              children: [
                const Text(
                  'Internet Connection',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final internetConnection =
                        ref.watch(internetConnectionProvider);
                    return internetConnection.when(
                      data: (data) {
                        return Text('$data');
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //네트워크 변화 감지
            Column(
              children: [
                const Text(
                  'Network Connectivity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final connectivityResults =
                        ref.watch(networkChangeProvider);
                    return connectivityResults.when(
                      data: (data) {
                        return Text('$data');
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //IP 정보
            Column(
              children: [
                const Text(
                  'IP',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final ip = ref.watch(ipProvider);
                    return ip.when(
                      data: (data) {
                        return Text('$data');
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //네트워크 정보
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'NETWORK INFO',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ref.invalidate(networkInfoProvider);
                        },
                        child: const Text('GET NETWORK INFO'))
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final networkInfo = ref.watch(networkInfoProvider);
                    return networkInfo.when(
                      data: (data) {
                        return Text('$data');
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //와이파이 목록
            Column(
              children: [
                const Text(
                  'WIFI LIST',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final wifis = ref.watch(wifisProvider);
                    return SizedBox(
                      width: 300,
                      height: 300,
                      child: wifis.when(
                        data: (wifis) {
                          return ListView.builder(
                            itemCount: wifis.length,
                            itemBuilder: (context, index) {
                              final wifi = wifis[index];
                              return Row(
                                children: [Text('${wifi.ssid}')],
                              );
                            },
                          );
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //네트워크 변경
            Consumer(
              builder: (context, ref, child) {
                final networkInfo = ref.watch(networkInfoProvider);
                return networkInfo.when(
                  data: (data) {
                    return Column(
                      children: [
                        Text(
                          'CHANGE NETWORK current:${data?.wifiName}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final networkInfo =
                                  await ref.watch(networkInfoProvider.future);
                              final wifiName = networkInfo!.wifiName;
                              developer.log('current wifiName:$wifiName');
                              if (wifiName!.contains('SQI-Support_2G')) {
                                developer.log('change to SQI-Support_5G');
                                await ref
                                    .read(networkNotifierProvider.notifier)
                                    .change(
                                        ssid: 'SQI-Support_5G',
                                        password: 'sqisoft74307');
                              } else {
                                developer.log('change to SQI-Support_2G');
                                await ref
                                    .read(networkNotifierProvider.notifier)
                                    .change(
                                        ssid: 'SQI-Support_2G',
                                        password: 'sqisoft74307');
                              }
                              //새로 고침
                              ref.invalidate(networkInfoProvider);
                              ref.invalidate(ipProvider);
                              ref.invalidate(wifisProvider);
                            },
                            child: const Text('change'))
                      ],
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            //UDP 멀티캐스트
            Column(
              children: [
                const Text(
                  'UDP MULTICAST',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final uDPMulticast = ref.watch(uDPMulticastProvider);
                    return uDPMulticast.when(
                      skipLoadingOnRefresh: false,
                      skipLoadingOnReload: false,
                      data: (data) {
                        return Text(data);
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const SizedBox.shrink(),
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      ref.read(uDPMulticastProvider.notifier).sendData(
                          'message UDP Multicast B ${Random().nextInt(100)}');
                    },
                    child: const Text('send'))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //SocketIO Server
            Column(
              children: [
                const Text(
                  'SOCKET IO SERVER',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final socketIOServer = ref.watch(socketIOServerProvider);
                    return socketIOServer.when(
                      skipLoadingOnRefresh: false,
                      skipLoadingOnReload: false,
                      data: (data) {
                        return Text(data);
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const SizedBox.shrink(),
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      ref.read(socketIOServerProvider.notifier).sendData(
                          'message socketIO B ${Random().nextInt(100)}');
                    },
                    child: const Text('send'))
              ],
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
