import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              primary: true,
              expandedHeight: 430,
              floating: false,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                background: Container(
                  child: Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      Container(
                        width: screenSize.width,
                        height: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://i.ytimg.com/vi/aEd5R_kAlq4/maxresdefault.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width,
                        height: 220,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              stops: [0.1, 0.4, 1.0],
                              colors: [
                                Colors.black54,
                                Colors.transparent,
                                Colors.black
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Super Mario Advance 4',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Mozart',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                      top: 240,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        width: screenSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Container(
                                child: Text(
                                  'Relive the Super Mario Bros 3 NES classic and save the princess once again with more enhanced graphics and refined sounds in Super Mario Advance 4! Super Mario Advance 4, also known as Super Mario Bros 3, is a Nintendo retro platformer for the Game Boy Advance (GBA) and an enhanced remake of the classic NES game Super Mario Bros 3. Players can choose between Mario or Luigi, and embark on an adventure through eight kingdoms of the Mushroom World to defeat the seven Koopa Kids and the all powerful Bowser, who have taken the seven magic rods from the kings of these seven kingdoms, transforming them into various creatures that you must defeat! Relive the classic in this amazing nostalgic game.',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Row(
                                children: <Widget>[
                                  FlatButton(
                                    textColor: Colors.white70,
                                    onPressed: () => print('My Favourite'),
                                    child: Container(
                                      height: 50.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Icon(
                                            Icons.favorite,
                                            size: 32.0,
                                          ),
                                          Text(
                                            'Favourite',
                                            style: TextStyle(fontSize: 10.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    textColor: Colors.white70,
                                    onPressed: () => print('Play/Download'),
                                    child: Container(
                                      height: 50.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Icon(
                                            Icons.file_download,
                                            size: 24.0,
                                          ),
                                          Text(
                                            'Play/Download',
                                            style: TextStyle(fontSize: 10.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    textColor: Colors.white70,
                                    onPressed: () => print('Share'),
                                    child: Container(
                                      height: 50.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Icon(
                                            Icons.share,
                                            size: 20.0,
                                          ),
                                          Text(
                                            'Share',
                                            style: TextStyle(fontSize: 10.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
