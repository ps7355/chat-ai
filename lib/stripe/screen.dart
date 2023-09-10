import 'package:chat_ai/stripe/payments.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:url_launcher/url_launcher.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextButton(
              child: Text('make payment'),
              onPressed: () async {
                //await getProducts('d188d27723772c7', '53fc2bd477dbd330df87');
                siva();
              }),
        ),
      ),
    );
  }
}
