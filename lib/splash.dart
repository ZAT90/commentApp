import 'dart:async';


import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage/preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription<ConnectivityResult> subscription;
  bool isConnectedToInternet = false;
  bool executeFuture = true;

  @override
  initState() {
    super.initState();
    initalizePreferences().then((value) =>
        debugPrint('langcode ${PreferenceManager.instance.langCode}'));
    check(); // check initially if the app is connected or not
    subscription =
        Connectivity() //subscribe to listen to the connectivity change
            .onConnectivityChanged
            .listen((ConnectivityResult result) {
      print('result: ' + result.toString());
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          isConnectedToInternet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    //print('connectivityResult' + connectivityResult.toString());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnectedToInternet = true;
      });
    } else {
      setState(() {
        isConnectedToInternet = false;
      });
    }
  }

  // Widget okButton =
  Future navigatetoHome(BuildContext context) async {
    await new Future.delayed(Duration(seconds: 3), () {
      if (isConnectedToInternet) {
        if (executeFuture) {
          setState(() {
            executeFuture = false;
            Navigator.pushNamed(context, '/home');
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertInternetorNav(context);
          },
        );
      }
    });
  }

  AlertDialog alertInternetorNav(BuildContext context) {
    return AlertDialog(
      title: Text("Alert"),
      content: Text("No Internet Connection"),
      actions: [
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    navigatetoHome(context);
    return new Scaffold(
        body: Container(
      color: Colors.blueGrey,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome to Comments App',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          // isConnectedToInternet != null
          //     ? !isConnectedToInternet
          //         ? Container(
          //             margin: EdgeInsets.only(top: 10),
          //             width: MediaQuery.of(context).size.width / 2,
          //             height: MediaQuery.of(context).size.height / 4,
          //             color: Colors.white,
          //             child: Center(
          //                 child: Text(
          //               'No Internet Connection available...!!!!',
          //               style: TextStyle(fontWeight: FontWeight.bold),
          //               textAlign: TextAlign.center,
          //             )))
          //         : Container()
          //     : Container()
        ],
      ),
    ));
  }
}

  Future initalizePreferences() async {
    PreferenceManager.init(await SharedPreferences.getInstance());
  }
