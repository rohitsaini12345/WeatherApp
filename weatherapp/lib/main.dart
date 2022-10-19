import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weatherapp/services/api_healper.dart';
import 'package:weatherapp/services/gps_healper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String city = "";
  double temp = 0.0;
  int humidity = 0;
  double latitude = 0;
  double longitude = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("weather.jpg"), fit: BoxFit.cover),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Weather App"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 120,
                      backgroundImage: AssetImage('images/weather.jpg'),
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "search location"),
                          onChanged: (value) {
                            city = value;
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var r = await ApiHelper(city).call_api();

                        Gps_Healper gps = Gps_Healper();
                        await gps.get_location();
                        print(r);

                        setState(() {
                          temp = r['current']['temp_c'];
                          humidity = r['current']['humidity'];
                          latitude = gps.latitude;
                          longitude = gps.longitude;
                        });
                      },
                      child: Text("search"),
                    ),
                    Text("temperature:" '${temp}'),
                    Text("humidity:" '${humidity}'),
                    Text("latitude:" '${latitude}'),
                    Text("longitude:" '${longitude}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
