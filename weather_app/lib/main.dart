import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Sample Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=6.95&lon=3.233333&appid=4ea0bcc9d4e65c15cd43482960ca04d6"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['temp'];
      this.currently = results['main'][0]['temp'];
      this.humidity = results['main']['temp'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Current Weather in Ikeja",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                temp != null ? temp.toString() + "\u00B0" : "Loading",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  currently != null ? currently.toString() : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            ListTile(
                leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                title: Text('Temperature'),
                trailing: Text(
                    temp != null ? temp.toString() + "\u00B0" : "Loading")),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text('Weather'),
                trailing: Text(
                    description != null ? description.toString() : "Loading")),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.sun),
              title: Text('Humidity'),
              trailing:
                  Text(humidity != null ? humidity.toString() : "Loading"),
            )
          ]),
        )),
      ]),
    );
  }
}
