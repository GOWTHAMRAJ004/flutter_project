import 'package:flutter/material.dart';
import "package:world_time_project/services/world_time.dart";

class Choose_Location extends StatefulWidget {
  const Choose_Location({super.key});

  @override
  State<Choose_Location> createState() => _Choose_LocationState();
}

class _Choose_LocationState extends State<Choose_Location> {
  //we are creating and calling the worldtime file
  List<WorldTime> locations = [
    WorldTime(location: 'London', flag: 'uk.png', url: 'Europe/London'),
    WorldTime(location: 'Athens', flag: 'greece.png', url: 'Europe/Berlin'),
    WorldTime(location: 'Cairo', flag: 'egypt.png', url: 'Africa/Cairo'),
    WorldTime(location: 'Nairobi', flag: 'kenya.png', url: 'Africa/Nairobi'),
    WorldTime(location: 'Chicago', flag: 'usa.png', url: 'America/Chicago'),
    WorldTime(location: 'New York', flag: 'usa.png', url: 'America/New_York'),
    WorldTime(location: 'Seoul', flag: 'south_korea.png', url: 'Asia/Seoul'),
    WorldTime(location: 'Jakarta', flag: 'indonesia.png', url: 'Asia/Jakarta'),
  ];
  void updatetime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'IsdayTime': instance.IsdayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose a location'),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  //print(locations[index].location);
                  //we are going to update the  time in the folling of pasing the instance
                  updatetime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  child: Image.asset('assets/${locations[index].flag}'),
                  backgroundColor: Colors.transparent,
                ),
                selectedColor: Colors.black,
              ),
            );
          }),
    );
  }
}
