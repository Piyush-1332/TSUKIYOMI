import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'detail_page.dart';
import 'random_generator.dart';
import 'package:http/http.dart' as http;

class Library extends StatefulWidget {
  final dynamic user;
  Library({Key key, this.user}) : super(key: key);
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  dynamic user_details = {"favorites": [], "downloads": []};

  @override
  void initState() {
    super.initState();
    getUserData();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  getUserData() async {
    http.Response user = await http.get(
        Uri.encodeFull(
            "https://tsukiyomi.herokuapp.com/api/user/get/${widget.user['phone']}"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        });
    if (user.statusCode == 200) {
      dynamic jsonParsed = jsonDecode(user.body);
      setState(() {
        user_details = jsonParsed;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  getLength(dynamic user) {
    if (user.containsKey('favorites') != null)
      return user['favorites'].length;
    else
      return 0;
  }

  getLengthDownloads(dynamic user) {
    if (user.containsKey('downloads'))
      return user['downloads'].length;
    else
      return 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottomOpacity: 0.5,
          // bottom: TabBar(
          //   indicator: UnderlineTabIndicator(
          //       borderSide: BorderSide(
          //         width: 4,
          //         color: Color(0xFF646464),
          //       ),
          //       insets: EdgeInsets.only(left: 0, right: 0, bottom: 4)),
          //   isScrollable: true,
          //   labelPadding: EdgeInsets.only(
          //       left: MediaQuery.of(context).size.width,
          //       right: MediaQuery.of(context).size.width),
          //   tabs: <Widget>[Tab(text: 'Favorites'), Tab(text: 'Downloads')],
          // ),
          title: Text(
            'Library',
            style: TextStyle(
                color: Colors.white.withOpacity(1.0),
                fontSize: 40.0,
                fontFamily: 'Mozart'),
          ),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GridView.builder(
                  itemCount: getLength(user_details),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  itemBuilder: (BuildContext context, int index) {
                    final item = user_details['favorites'][index];
                    return GridTile(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
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
                              child: Card(
                                margin: EdgeInsets.symmetric(vertical: 0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  "https://tsukiyomi.herokuapp.com/Images/image${item['refid']}.jpg",
                                  fit: BoxFit.fitHeight,
                                ),
                              ))),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
