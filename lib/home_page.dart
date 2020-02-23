import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tsukiyomi/detail_page.dart';
import 'random_generator.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  final dynamic user;
  Homepage({Key key, this.user}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  getLength(dynamic user) {
    if (user.containsKey('user_history'))
      return user['user_history'].length;
    else
      return 0;
  }

  dynamic recommended = [{}];
  getRecommendedRoms(dynamic phone) async {
    http.Response recommended_resp = await http.get(Uri.encodeFull(
        "https://tsukiyomi.herokuapp.com/api/user/recommended/$phone"));
    print(recommended_resp.body);
    if (recommended_resp.statusCode == 200) {
      setState(() {
        if (jsonDecode(recommended_resp.body).length > 0)
          recommended = jsonDecode(recommended_resp.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRecommendedRoms(widget.user['phone']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0x990000), Colors.black],
              begin: Alignment.topCenter,
              end: FractionalOffset(0.3, 0.3))),
      child: ListView(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 0.0),
                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Recently Played',
                        style: TextStyle(
                            color: Colors.white.withOpacity(1.0),
                            fontSize: 40.0,
                            fontFamily: 'Mozart'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 130.0,
                  child: getLength(widget.user) == 0
                      ? SizedBox(
                          height: 200.0,
                          width: 150.0,
                          child: Center(
                              child: Text(
                            "Nothing to See Yet",
                            style: TextStyle(fontSize: 20.0),
                          )),
                        )
                      : ListView.builder(
                          itemCount: getLength(widget.user),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final item = widget.user.user_history[index];
                            return Column(
                              children: <Widget>[
                                Expanded(
                                  child: new GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute<Null>(
                                          builder: (BuildContext context) {
                                            return new Detail(
                                                index: item.refid,
                                                user: widget.user);
                                          },
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 200.0,
                                      width: 150.0,
                                      child: Image.network(
                                        "${item.thumnail}",
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
                /*comment*/
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 0.0),
                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Made For You',
                        style: TextStyle(
                            color: Colors.white.withOpacity(1.0),
                            fontSize: 40.0,
                            fontFamily: 'Mozart'),
                      ),
                    ],
                  ),
                ),
                /*comment*/
                Container(
                  height: 220.0,
                  child: ListView.builder(
                    itemCount: recommended.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      if (recommended[index].containsKey('refid')) {
                        var item = recommended[index];
                        return Column(
                          children: <Widget>[
                            Expanded(
                              child: new GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                        return new Detail(
                                            index: item['refid'],
                                            user: widget.user);
                                      },
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 150.0,
                                  width: 240.0,
                                  child: Image.network(
                                    "https://tsukiyomi.herokuapp.com/Images/image${item['refid']}.jpg",
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else
                        return Column(
                          children: <Widget>[
                            Expanded(
                              child: new GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                        return new Detail(
                                            index: index, user: widget.user);
                                      },
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 150.0,
                                  width: 240.0,
                                  child: Image.network(
                                    "https://tsukiyomi.herokuapp.com/Images/image${index}.jpg",
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 0.0),
                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Popular & Trending',
                        style: TextStyle(
                            color: Colors.white.withOpacity(1.0),
                            fontSize: 40.0,
                            fontFamily: 'Mozart'),
                      ),
                    ],
                  ),
                ),
                /*comment*/
                Container(
                  height: 185.0,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Expanded(
                              child: new GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return new Detail(
                                        index: index, user: widget.user);
                                  },
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 170.0,
                              width: 205.0,
                              child: Image.network(
                                "https://tsukiyomi.herokuapp.com/Images/image$index.jpg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ))
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
