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
            Column(
              children: [
                const Text(
                  'NETWORK INFO',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                      loading: () => const CircularProgressIndicator(),
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      ref
                          .read(uDPMulticastNotifierProvider.notifier)
                          .sendData('message B ${Random().nextInt(100)}');
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
