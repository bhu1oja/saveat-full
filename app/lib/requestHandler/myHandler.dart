import 'package:http/http.dart' as http;

Future<dynamic> makePostRequest(url, bodyData) async {
  final uri = url;
  var body = bodyData;
  var response = await http.post(
    uri,
    body: body,
  );

  return response.body;
}

Future<dynamic> makeGetRequest(url) async {
  final uri = url;
  var response = await http.get(uri);
  return response.body;
}
