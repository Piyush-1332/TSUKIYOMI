import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:platform/platform.dart';
import 'package:android_intent/android_intent.dart';
import 'package:device_apps/device_apps.dart';

class Detail extends StatefulWidget {
  final int index;
  final dynamic user;
  Detail({Key key, this.index, this.user}) : super(key: key);
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  String name = "Loading";
  String description = "Loading";
  String thumbnail = "Loading";
  Color isFavorite;
  dynamic rom;
  void initState() {
    super.initState();
    getRomData();
  }

  getRomData() async {
    http.Response response = await http.get(Uri.encodeFull(
        "https://tsukiyomi.herokuapp.com/api/game/get/${widget.index}"));
    if (response.statusCode == 200) {
      print(response.body);
      dynamic jsonParsed = jsonDecode(response.body);
      setState(() {
        rom = jsonParsed;
        name = jsonParsed['name'];
        description = jsonParsed['name'];
        thumbnail = jsonParsed['thumbnail'];
      });
      http.Response liked = await http.get(Uri.encodeFull(
          "https://tsukiyomi.herokuapp.com/api/user/favorite/${widget.user['phone']}/${jsonParsed['_id']}"));
      if (liked.statusCode == 200) {
        print(liked.body);
        dynamic fav = jsonDecode(liked.body);
        setState(() {
          if (fav == true)
            isFavorite = Colors.red;
          else
            isFavorite = null;
        });
      }
    }
  }

  addToFavorites() async {
    int phone = widget.user['phone'];
    String phoneStr = phone.toString();
    Map data = {
      'update': 'favorite',
      "favorite": rom,
    };
    var body = jsonEncode(data);
    http.Response user = await http.put(
        Uri.encodeFull(
            "https://tsukiyomi.herokuapp.com/api/user/edit/$phoneStr"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    if (user.statusCode == 200) {
      dynamic jsonParsed = jsonDecode(user.body);
      print(jsonParsed);
      setState(() {
        if (jsonParsed['liked'])
          isFavorite = Colors.red;
        else
          isFavorite = null;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              primary: true,
              expandedHeight: MediaQuery.of(context).size.height,
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
                        height: 520,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("$thumbnail"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width,
                        height: 520,
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
                                  "$name",
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
                        top: 540,
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
                                    "$description",
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
                                      onPressed: () => addToFavorites(),
                                      child: Container(
                                        height: 50.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Icon(
                                              Icons.favorite,
                                              color: isFavorite,
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
                                      onPressed: () => androidIntent(),
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
