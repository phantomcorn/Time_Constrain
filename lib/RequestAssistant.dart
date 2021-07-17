import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAssistant {

  static Future<dynamic> getRequest(String url) async {

    http.Response response = await http.get(Uri.parse(url));

    try {

      if (response.statusCode == 200) {
        String jsonData = response.body;
        Map<String,dynamic> decodeDate = jsonDecode(jsonData);
        return decodeDate;

      } else {

        return "Failed";

      }

    } catch (exp) {

      return "Failed";

    }
  }

}

