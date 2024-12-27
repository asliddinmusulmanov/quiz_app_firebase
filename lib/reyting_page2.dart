import 'package:flutter/material.dart';

class ReytinPage2 extends StatelessWidget {
  const ReytinPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Level"),
        actions: const [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.green,
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const SizedBox(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
