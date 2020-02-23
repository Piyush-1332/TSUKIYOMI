import 'dart:convert';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsukiyomi/home_page.dart';
import 'package:tsukiyomi/browse_page.dart';
import 'package:tsukiyomi/library_page.dart';
import 'package:tsukiyomi/more_page.dart';
import 'package:http/http.dart' as http;
import 'package:device_apps/device_apps.dart';
import 'package:platform/platform.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Start extends StatefulWidget {
  final dynamic phone;
  Start({Key key, this.phone}) : super(key: key);
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  int index = 0;
  dynamic user;
  static const snackBarDuration = Duration(seconds: 3);
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    http.Response user_details = await http.get(
        Uri.encodeFull(
            "https://tsukiyomi.herokuapp.com/api/user/get/${widget.phone}"),
        headers: {"Accept": "application/json"});
    print(user_details.body);
    if (user_details.statusCode == 200) {
      dynamic jsonParsed = jsonDecode(user_details.body);
      setState(() {
        user = jsonParsed;
      });
    }
  }

  final snackBar = SnackBar(
    content: Text('Press back again to leave'),
    duration: snackBarDuration,
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime backButtonPressTime;
  androidIntent() async {
    bool isInstalled = await DeviceApps.isAppInstalled('com.fastemulator.gba');
    if (isInstalled) {
      DeviceApps.openApp('com.fastemulator.gba');
    } else {
      if (const LocalPlatform().isAndroid) {
        final AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data: Uri.encodeFull(
                "https://tsukiyomi.herokuapp.com/apk/emulator.apk"),
            package:
                "com.android.chrome.implicit.fallback" // replace com.example.app with your applicationId
            );
        await intent.launch();
      }
    }
  }

  Future<bool> _onBackPressed() {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldKey.currentState.showSnackBar(snackBar);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    return Future.value(true);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          top: 130.0,
        ),
        child: FloatingActionButton(
            elevation: 0.0,
            mini: false,
            splashColor: Color.fromRGBO(255, 255, 255, 0),
            child: Center(child: Icon(Icons.play_arrow)),
            onPressed: () => androidIntent(),
            foregroundColor: Colors.red[900],
            backgroundColor: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      key: scaffoldKey,
      body: WillPopScope(
          onWillPop: () => _onBackPressed(), child: show(index, user)),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        height: 50.0,
        buttonBackgroundColor: Colors.grey[900],
        backgroundColor: Colors.red[900],
        onTap: ((int x) {
          setState(() {
            index = x;
            show(index, user);
          });
        }),
        items: [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.file_download),
          Icon(Icons.list)
        ],
      ),
    );
  }
}

Widget show(int index, dynamic user) {
  switch (index) {
    case 0:
      return Homepage(user: user);
      break;
    case 1:
      return Browse(user: user);
      break;
    case 2:
      return Library(user: user);
      break;
    case 3:
      return More(user: user);
      break;
    default:
      return Homepage(user: user);
      break;
  }
}
