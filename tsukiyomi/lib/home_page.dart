import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatelessWidget {
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
                  padding: EdgeInsets.all(20.0),
                  height: 20.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.gamepad),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 45.0, 0.0, 0.0),
                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Recently Played',
                        style: TextStyle(
                          color: Colors.white.withOpacity(1.0),
                          fontSize: 23.0,fontFamily: 'Gtek',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 160.0,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 120.0,
                            width: 145.0,
                            child: Image.network(
                              'https://www.mobygames.com/images/covers/l/55382-super-mario-advance-4-super-mario-bros-3-game-boy-advance-front-cover.jpg',
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                /*comment*/
                Container(
                  padding: EdgeInsets.fromLTRB(20.0,20.0, 0.0, 0.0),
                  height: 70.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Made For You',
                        style: TextStyle(
                          color: Colors.white.withOpacity(1.0),
                          fontSize: 23.0,fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                /*comment*/
                Container(
                  height: 270.0,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 230.0,
                            width: 280.0,
                            child: Image.network(
                              'https://www.mobygames.com/images/covers/l/55382-super-mario-advance-4-super-mario-bros-3-game-boy-advance-front-cover.jpg',
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                  height: 80.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Popular & Trending',
                        style: TextStyle(
                          color: Colors.white.withOpacity(1.0),
                          fontSize: 23.0,fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                /*comment*/
                Container(
                  height: 200.0,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 170.0,
                            width: 210.0,
                            child: Image.network(
                              'https://www.mobygames.com/images/covers/l/55382-super-mario-advance-4-super-mario-bros-3-game-boy-advance-front-cover.jpg',
                              fit: BoxFit.fitHeight,
                            ),
                          )
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
