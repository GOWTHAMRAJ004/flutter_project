import 'package:flutter/material.dart';
import 'package:world_time_project/pages/choose_location.dart';
import 'package:world_time_project/pages/home.dart';
import 'package:world_time_project/pages/loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    data = data != null
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Set background image and color based on 'IsdayTime'
    String bgImage = (data != null && data!['IsdayTime'] != null)
        ? (data!['IsdayTime'] ? 'day.jpg' : 'night.jpeg')
        : 'night.jpeg';
    // setting the background colour based on the isdaytime
    Color? bgColour = (data!['IsdayTime'] ? Colors.blue : Colors.indigo[700]);

    if (data == null ||
        data!['location'] == null ||
        data!['time'] == null ||
        data!['IsdayTime'] == null) {
      return Scaffold(
        body: Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColour,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/choose_location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'time': result['time'],
                        'IsdayTime': result['IsdayTime'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  label: Text(
                    'Edit location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                  icon: Icon(
                    Icons.add_location_alt,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data!['location'],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  data!['time'],
                  style: TextStyle(fontSize: 66.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
