import 'package:flutter/material.dart';



class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

  @override
  State<DeviceListPage> createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 32, right: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Devices", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey,
                  ),
                  child: const Center(
                    child: Icon(Icons.add, size: 24, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("15 Devices", style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
              IconButton(
                icon: Icon(Icons.refresh_rounded, color: Colors.grey.shade400, size: 20),
                onPressed: () {

                },
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: deviceComponent(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget deviceComponent() {
    return Container(
      width: 296,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(10)
      ),
      child: const Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.wifi_off_rounded, color: Colors.black, size: 16),
                SizedBox(width: 8),
                Text("Device name", style: TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 24.0),
              child: Text("Device ID"),
            )
          ],
        ),
      ),
      

    );
  }

}