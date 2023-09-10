import 'package:chat_ai/my-account.dart';
import 'package:chat_ai/pricing_cards.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import './home.dart';
import 'Authentication/forgot_password.dart';
import 'Authentication/sign_in.dart';
import 'Authentication/sign_up.dart';
import 'Authentication/update_password.dart';
import 'code_box.dart';
import 'result-display.dart';
import 'stripe/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// TODO: replace with your credentials
  await Supabase.initialize(
    // url: 'https://yoursupabaseurl.supabase.co',
    // anonKey: 'your_anon_key',
    url: 'https://eavysytlchdlplvfwifp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVhdnlzeXRsY2hkbHBsdmZ3aWZwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzg1MzYwMzcsImV4cCI6MTk5NDExMjAzN30.H0KnuKyQ2ltrbLwayA5RyziOmtaQ7m0e7-uU7t2wrCA',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.roboto().toString(),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(24),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.deepPurple),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const SignIn(),
        '/sign_in': (context) => const SignUp(),
        '/forgot_password': (context) => const ForgotPassword(),
        '/update_password': (context) => const UpdatePassword(),
        '/pricing': (context) => const PricingTable(),
        '/home': (context) => const Home(),
        '/account': (context) => const MyAccount(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const Scaffold(
            body: Center(
              child: Text(
                'Not Found',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
