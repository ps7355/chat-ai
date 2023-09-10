import 'package:chat_ai/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Ionicons.arrow_back)),
          backgroundColor: Colors.black,
          title: Text(
            'My Account',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Text(
                      currentPlan,
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 40),
                    ),
                    const SizedBox(width: 50),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {},
                        child: Text('Upgrade My Plan'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
