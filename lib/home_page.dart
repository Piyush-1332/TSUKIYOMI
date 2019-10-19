import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tsukiyomi/detail_page.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                                      return new Detail();
                                    },
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 200.0,
                                width: 150.0,
                                child: Image.network(
                                  'https://www.mobygames.com/images/covers/l/55382-super-mario-advance-4-super-mario-bros-3-game-boy-advance-front-cover.jpg',
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
                                      return new Detail();
                                    },
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 150.0,
                                width: 240.0,
                                child: Image.network(
                                  'https://www.mobygames.com/images/covers/l/55382-super-mario-advance-4-super-mario-bros-3-game-boy-advance-front-cover.jpg',
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
                      return Column(children: <Widget>[
                        Expanded(
                          child: new GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return new Detail();
                                  },
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 170.0,
                              width: 205.0,
                              child: Image.network(
                                'https://www.mobygames.com/images/covers/l/55382-super-mario-advance-4-super-mario-bros-3-game-boy-advance-front-cover.jpg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ]);
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
