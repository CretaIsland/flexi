import 'package:flutter/material.dart';



class ContentListPage extends StatefulWidget {
  const ContentListPage({super.key});

  @override
  State<ContentListPage> createState() => _ContentListPageState();
}

class _ContentListPageState extends State<ContentListPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 32, right: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Contents", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/contentDetail");
                },
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
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              width: 296,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)
              )
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: contentComponent(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget contentComponent() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/contentDetail");
      },
      onLongPress:  () {

      },
      child: Container(
        width: 296,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 272,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey
                ),
              ),
              const SizedBox(height: 14),
              const Text("Content name", style: TextStyle(fontSize: 12, color: Colors.black))
    
            ],
          ),
        ),
        
    
      ),
    );
  }

}