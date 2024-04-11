import 'package:golden_test/Core/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getCategories(String id) async {
  Uri uri;
  if (id == '') {
    uri = Uri.parse(kGetCategoriesUrl);
  } else {
    uri = Uri.parse('$kGetCategoriesUrl/$id');
  }
print('k$uri');
  var response = await http.get(uri);

  var p = json.decode(response.body);
  if (response.statusCode == 200) {
    return p['data'];
  } else {
    return [];
  }
}
