import 'package:http/http.dart' as http;

final String productID = 'dyruy';
final String email = 'denver@gmail.com';
final String accessToken = 'WuGMo629asjVlso_1FwdLD2FNkw1MCBScgdzEixUock';

Future<void> siva() async {
  String url =
      'https://api.gumroad.com/v2/products/$productID/subscribers?email=$email';

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    print(response.body);
    // Success! Do something with the response.
  } else {
    print('failed');
    // Error :( Handle the error and show an error message to the user.
  }
}
