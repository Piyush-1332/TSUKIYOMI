import 'package:flutter/material.dart';
import 'package:tsukiyomi/home_page.dart';
import 'package:tsukiyomi/browse_page.dart';
import 'package:tsukiyomi/library_page.dart';
import 'package:tsukiyomi/login2.dart';
class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  int index=0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: show(index),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xAA000000),
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.redAccent,
          unselectedFontSize: 9,
          selectedFontSize: 11,
          onTap: ((int x){
            setState(() {
             index = x;
             show(index);
            });
          }),
          
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Browse'), 
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.file_download),
              title: Text('Library'),
              
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('More'),
            ),
          ],
        ),
      ),
    );
  }
}
Widget show(int index){
  switch(index){
    case 0: return Homepage();
    break;
    case 1: return Browse();
    break;
    case 2: return Library();
    break;
    case 3: return LoginScreen3();
    break;
    default: return Homepage();
    break;
  }
}
