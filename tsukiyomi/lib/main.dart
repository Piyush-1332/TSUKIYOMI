import 'package:flutter/material.dart';

import 'HomePage.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.black,
        primarySwatch: Colors.red
      ),
      home: new HomePage(),
    );
  }
}