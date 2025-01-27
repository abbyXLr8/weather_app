import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherWidget extends StatefulWidget {
  final String name;
  const WeatherWidget({super.key, required this.name});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  dynamic data;
  dynamic temp;
  dynamic icon;
  dynamic feelslike;
  dynamic max, min;
  dynamic date;
  dynamic time1;
  Future<void> updateButton(String city) async {
    final String apiKey = 'e031c9f97a2b4d12957153940251801';
    var url = Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?q=$city&day_Element&key=e031c9f97a2b4d12957153940251801');
    print(url);
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      print("data retrival successul");
      data = jsonDecode(response.body);
      print(data['current']['temp_c']);
      temp = data['current']['temp_c'];

      icon = data['current']['condition']['icon'];
      print("DEBUG:$icon");
      feelslike = data['current']['condition']['text'];
      print("DEBUG:$feelslike");
      max = data['forecast']['forecastday'][0]['day']['maxtemp_c'];
      print("DEBUG:$max");
      min = data['forecast']['forecastday'][0]['day']['mintemp_c'];
      print("DEBUG:$min");
      date = data['forecast']['forecastdate'][0]['date'];
      print("DEBUG: $date");
      time1 = data['forecast']['forecastdate'][0]['hour']['time'];
      print(time1);
    } else {
      print("data retrival failed");
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateButton('Paris');
    print('DEBUG: ${widget.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(255, 0, 37, 68),
                      Colors.deepPurple,
                      Colors.purple,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,
                          ),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/weather_icon.png"),
                              ),
                            ),
                            // child: Image.network('https:$icon'),
                          ),
                          Text(
                            "$temp°C",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 90,
                            ),
                          ),
                          Text(
                            "$feelslike",
                            style: TextStyle(
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Text(
                                  "Min: $min",
                                  style: TextStyle(
                                    color: Colors.white,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                ),
                                Text(
                                  "Max: $max",
                                  style: TextStyle(
                                    color: Colors.white,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/house.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            const Color.fromARGB(255, 0, 37, 68),
                            Colors.deepPurple,
                            Colors.purple,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Today",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 280,
                                ),
                                Text(
                                  "$date",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 90,
                                  width: 70,
                                  color: Colors.transparent,
                                  child: Text("$time1"),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 90,
                                  width: 70,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 90,
                                  width: 70,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 90,
                                  width: 70,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
