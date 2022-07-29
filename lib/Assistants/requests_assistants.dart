import 'dart:convert';

import 'package:http/http.dart' as http;

String url = '';

class RequestAssistant {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodedData = jsonDecode(jsonData);
        return decodedData;
      } else {
        return 'faild';
      }
    } catch (exp) {
      return 'faild';
    }
  }
}
