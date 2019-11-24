import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> PostReq(String url, String data) async {
    var response = await http.post(url, body: data);
    Map resp = json.decode(response.body);
    return resp["text"];
}

int calculate() {
  return 6 * 7;
}
