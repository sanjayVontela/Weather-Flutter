import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper{

  NetworkHelper(this.url);
  final String url;
  Future getData() async{
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    if(response.statusCode == 200) {
      String data = response.body;
      return json.decode(data);
    }else{
      print(response.statusCode);
    }
  }

}