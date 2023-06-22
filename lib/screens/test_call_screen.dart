import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 243, 239),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height *
                    0.5, // Responsive image height
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'images/testCall.jpeg'), // Replace with your image path
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Receiving a call'.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'When someone is requesting your help, you will receive a notification and hear the ringtone if your sound is on. To answer, simply press the notification and you will be taken to the call.'
                    .tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              // Other widgets or content here
            ],
          ),
        ),
      ),
    );
  }
}
