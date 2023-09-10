import 'dart:convert';
import 'package:chat_ai/Authentication/constants.dart';
import 'package:http/http.dart' as http;

var parts = [];
Future<String> getAnswers(String prompt) async {
  var apiKey = apiSceretKey;
  var url = Uri.https("api.openai.com", "/v1/chat/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $apiKey"
    },
    body: json.encode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": prompt}
      ],
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );

  Map<String, dynamic> receivedData = jsonDecode(response.body);
  // this is text print(receivedData['choices'][0]['message']['content'].split('```')[0]);
  // this is code responseJson['choices'][0]['message']['content'].split('```')[1];
  ///print(receivedData['choices'][0]['message']['content'].split('```')[1]);
  ///var message = responseJson['choices'][0]['message']['content'];
  var delimiter = '```';

// Split message into text and code portions and store them in a list
  var message = receivedData['choices'][0]['message']['content'];
  var startIndex = 0;
  while (true) {
    var delimiterIndex = message.indexOf(delimiter, startIndex);
    if (delimiterIndex == -1) {
      // Add the last text portion to the parts list
      parts.add({'text': message.substring(startIndex)});
      break;
    }
    // Add the text portion before the code to the parts list
    parts.add({'text': message.substring(startIndex, delimiterIndex)});

    // Find the next delimiter
    startIndex = delimiterIndex + delimiter.length;
    delimiterIndex = message.indexOf(delimiter, startIndex);
    if (delimiterIndex == -1) {
      // Add the last code portion to the parts list
      parts.add({'code': message.substring(startIndex)});
      break;
    }
    // Add the code portion to the parts list
    parts.add({'code': message.substring(startIndex, delimiterIndex)});

    // Update the start index for the next iteration
    startIndex = delimiterIndex + delimiter.length;
  }
  print(parts);
  return '';
}
