import 'dart:convert';

import 'package:http/http.dart' as http;
class DataService{
  List<dynamic> b = [];
  Future<List> getQuotes() async {
    try{
      final response = await http.get(Uri.parse("https://zenquotes.io/api/random"));
      if(response.statusCode == 200){
        var result = jsonDecode(response.body);
        return result;
      }else{
        throw Exception('Faild to load quotes');
      }
    }catch(e){
      rethrow;
    }
    
  }
}