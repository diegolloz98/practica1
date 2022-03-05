import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
class DataService{
  final Uri url = Uri(
        scheme: "https", host: "picsum.photos", path: "seed/${new Random().nextInt(999999)}/900/1110");
  Future getImages() async {
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        var image = response.bodyBytes;
        return image;
      }else{
        throw Exception('Faild to load quotes');
      }
    }catch(e){
      rethrow;
    }
    
  }
}