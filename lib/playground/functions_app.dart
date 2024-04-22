import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  'Network Change',
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
                      height: 500,
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
                        loading: () => const CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
