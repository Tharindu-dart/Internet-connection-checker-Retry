import 'dart:async';
import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:connectivity/connectivity.dart';
//import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool connection;

//=======================================================================
  isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        setState(() {
          connection = true;
        });
        //return true;
      } else {
        // Mobile data detected but no internet connection found.
        setState(() {
          connection = false;
        });
        //return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        setState(() {
          connection = true;
        });
        //return true;
      } else {
        // Wifi detected but no internet connection found.
        setState(() {
          connection = false;
        });
        //return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      setState(() {
        connection = false;
      });
      //return false;
    }
  }

//======================================================================
  @override
  void initState() {
    super.initState();
    isInternet();
  }

  @override
  Widget build(BuildContext context) {
    print("$connection");
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 300.0),
            Text("$connection"),
            RaisedButton(
              child: Text("Retry"),
              onPressed: () {
                isInternet();
              },
            ),
          ],
        ),
      ),
    );
  }
}
