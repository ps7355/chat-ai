import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../Backend/database.dart';
import 'constants.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign Up'),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          SupaEmailAuth(
            authAction: SupaAuthAction.signUp,
            redirectUrl: '/home',
            onSuccess: (_) {
              addPlanDetails();
              Navigator.of(context).pushReplacementNamed('/pricing');
            },
            metadataFields: [
              MetaDataField(
                prefixIcon: const Icon(Icons.person),
                label: 'Username',
                key: 'username',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter something';
                  }
                  return null;
                },
              ),
            ],
          ),
          TextButton(
            child: const Text(
              'Already have an account? Sign In',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/sign_in');
            },
          ),
          const Divider(),
          optionText,
          spacer,
          SupaSocialsAuth(
            colored: true,
            redirectUrl:
                'https://eavysytlchdlplvfwifp.supabase.co/auth/v1/callback',
            socialProviders: [
              SocialProviders.google,
            ],
            onSuccess: (session) {
              Navigator.of(context).pushReplacementNamed('/pricing');
            },
          ),
        ],
      ),
    );
  }
}
