import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Tsukiyomi'),
        centerTitle: true,
      ),
      drawer: new Drawer(),
      body: Stack(
        children: <Widget>[
          Center(
            child: new Image.asset(
              'assets/back2.jpg',
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
      bottomNavigationBar: new Container(
        color: Colors.black,
        height: 60.0,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.home,
                size: 35.0,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            new IconButton(
              icon: Icon(
                Icons.search,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            new IconButton(
              icon: Icon(
                Icons.star,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            new IconButton(
              icon: Icon(
                Icons.settings,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
