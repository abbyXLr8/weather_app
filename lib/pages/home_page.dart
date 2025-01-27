import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_http/pages/weather.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _namecontroller = TextEditingController();
  var uri = Uri.parse(
      'https://api.weatherapi.com/v1/forecast.json?q=delhi&day_Element&key=e031c9f97a2b4d12957153940251801');
  dynamic name;

  void getData() async {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var dataGotten = jsonDecode(response.body);
      name = "";
      setState(() {});
    } else {
      //show an eroor
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                      height: MediaQuery.of(context).size.height * 1,
                      child: Column(
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,
                          ),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/weather_icon.png"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter city',
                                fillColor: Colors.white,

                                //border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WeatherWidget(
                                    name: _namecontroller.text,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(
                                  "Search",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
