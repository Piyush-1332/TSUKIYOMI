import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'random_generator.dart';
import 'package:http/http.dart' as http;

class Browse extends StatefulWidget {
  final dynamic user;
  Browse({Key key, this.user}) : super(key: key);
  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  dynamic genres = [
    {"name": "Loading"}
  ];
  MediaQueryData queryData;

  getGenres() async {
    http.Response resp = await http.get(
        Uri.encodeFull("https://tsukiyomi.herokuapp.com/api/genre/list/all"));
    print(resp.body);
    if (resp.statusCode == 200) {
      setState(() {
        genres = jsonDecode(resp.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getGenres();
  }

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
                            itemCount: widget.user['genres'].length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            itemBuilder: (BuildContext context, int index) {
                              final item = widget.user['genres'][index];
                              return GridTile(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Card(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 0.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      clipBehavior: Clip.antiAlias,
                                      child: Center(child: Text(item))),
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
                            itemCount: genres.length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            itemBuilder: (BuildContext context, int index) {
                              final item = genres[index];
                              return GridTile(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Card(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 0.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      clipBehavior: Clip.antiAlias,
                                      child: Center(child: Text(item['name']))),
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
