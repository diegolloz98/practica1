import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DataService{
  Future<String> getTime(String continent, String country) async {
    try{
      final response = await http.get(Uri.parse("http://worldtimeapi.org/api/timezone/$continent/$country"));
      if(response.statusCode == 200){
        Map map  = jsonDecode(response.body);
        //print(map);
        var result = map['datetime'];
        String dateTime = map['datetime'];
        String offset = map['utc_offset'].substring(1, 3);
        DateTime time = DateTime.parse(dateTime);
        time = time.add(Duration(hours: int.parse(offset)));
        print(DateFormat.Hms().format(time));
        final timeStr = DateFormat('hh : mm a').format(time);
        //print(timeStr);
        //print(timeStr.substring(0, 7));
        return DateFormat.Hms().format(time);
      }else{
        throw Exception('Faild to load timesZone');
      }
    }catch(e){
      rethrow;
    }
    
  }
}