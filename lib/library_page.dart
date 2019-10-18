import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }
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
  tabs: <Widget>[
    Tab(text:'data'
  ),Tab(text:'data2')],
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
            children: [Container(
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
                    ),),
              Icon(Icons.directions_transit)
            ],
          ),
        ),
      );
  }
}
