import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Model.dart';

class APIHelper {
  APIHelper._();
  static final APIHelper apiHelper = APIHelper._();

  Future<Currency?> fetchData() async {
    String api =
        "https://v6.exchangerate-api.com/v6/8e87a865e36c97b117a13692/latest/USD";
    http.Response res = await http.get(Uri.parse(api));
    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);
      Currency dataAll = Currency.fromJson(json: decodedData);
      return dataAll;
    }
    return null;
  }
}
