import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
  }

  void getData() async {

    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=a4d3feec9e573c25a0e853774ba5bc75');

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    }
    else {
      print(response.statusCode);
    }
  }

//  this is Didmount method in flutter.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    getData();
  }

// this is Willunmount life cycle method used in flutter.
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            //Get the current location
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
