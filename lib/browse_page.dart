import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Browse extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x990000), Colors.black],
            begin: Alignment.bottomCenter,
            end: FractionalOffset(0.3, 0.3),
          ),
        ),
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(30.0),
                  ),
                  Container(
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white.withOpacity(1.0),
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: (screenSize.width - 30),
                      height: 50.0,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.search, color: Colors.black),
                          Text(
                            'Genre, Games or Titles       ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Your Top Genres',
                            style: TextStyle(
                              color: Colors.white.withOpacity(1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GridView.builder(
                            itemCount: 3,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            itemBuilder: (BuildContext context, int index) {
                              return GridTile(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Card(
                                    margin: EdgeInsets.symmetric(vertical: 0.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.network(
                                      'https://www.mobygames.com/images/covers/l/55382-super-mario-advance-4-super-mario-bros-3-game-boy-advance-front-cover.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Browse All',
                            style: TextStyle(
                              color: Colors.white.withOpacity(1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GridView.builder(
                            itemCount: 5,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            itemBuilder: (BuildContext context, int index) {
                              return GridTile(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Card(
                                    margin: EdgeInsets.symmetric(vertical: 0.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.network(
                                      'https://www.mobygames.com/images/covers/l/55382-super-mario-advance-4-super-mario-bros-3-game-boy-advance-front-cover.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
