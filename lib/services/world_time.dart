import 'dart:core';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {
  String location; //location on the  UI
  String time; //the time in that location
  String flag; //url to the assert flag icon
  String url; // it define that the part of json url
  late bool IsdayTime; //wheathe rit is a day or night

  WorldTime({required this.location, required this.flag, required this.url})
      : time = '';

  Future<void> getTime() async {
    http.Response response =
        await http.get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
    Map date = jsonDecode(response.body);
    // print(data);
    String dateTime = date['datetime'];
    String offset = date['utc_offset'].substring(1, 3);
    print(dateTime);
    print(offset);
    //creating a datatime object because we need to add these
    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));
    IsdayTime = now.hour > 6 && now.hour < 20 ? true : false;
    //print(now);
    time = DateFormat.jm().format(now);
    print(time);
  }
}
