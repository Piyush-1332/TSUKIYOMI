import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}
class _LibraryState extends State<Library> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottomOpacity: 0.5,
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4,
                color: Color(0xFF646464),
              ),
              insets: EdgeInsets.only(
                left: 0,
                right: 8,
                bottom: 4)),
                isScrollable: true,
              labelPadding: EdgeInsets.only(left: 0, right: 0),
              tabs: [
                Padding(padding: EdgeInsets.only(right:-50.0),child: Tab(text:'Downloads'),),
                Padding(padding: EdgeInsets.only(right:-50.0),child: Tab(text:'Downloads'),)
              ],
            ),
            title: Text(
                        'Library',
                        style: TextStyle(
                          color: Colors.white.withOpacity(1.0),
                          fontSize: 40.0,fontFamily: 'Mozart'
                        ),
                      ),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit)
            ],
          ),
        ),
      );
  }
}
