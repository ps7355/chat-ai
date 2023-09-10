import 'package:supabase_flutter/supabase_flutter.dart';

void addPlanDetails() async {
  var currentUser = Supabase.instance.client.auth.currentUser;
  if (currentUser == null) {
    throw 'no user';
  }
  var uid = currentUser.id;
  await Supabase.instance.client
      .from('users')
      .insert({'uid': uid, 'plan': 'free'}).execute();
}

Future<String> getPlanData() async {
  var currentUser = Supabase.instance.client.auth.currentUser;
  var uid = currentUser?.id;
  final data = await Supabase.instance.client
      .from('users')
      .select('uid, plan')
      .eq('uid', uid)
      .execute();

  if (data != null) {
    return data.data[0]['plan'];
  } else {
    throw 'error';
  }
}
