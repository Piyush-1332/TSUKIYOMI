import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<Loginpage> {
  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 60.0,
          height: 1.0,
          color: Colors.white.withOpacity(0.6),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: false ,
      body: Container(
        padding: const EdgeInsets.all(40.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.brown, Colors.black],
                begin: Alignment.topCenter,
                end: FractionalOffset(0.3, 0.3))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text('Tsukiyomi',
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54)),
            ),
            SizedBox(
              height: screensize.height / 14,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: TextField(
                  style: TextStyle(color: Theme.of(context).accentColor),
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                  obscureText: false,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            new RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
              padding: EdgeInsets.only(),
              color: Colors.white,
              child: Text('Sign in', style: TextStyle(color: Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    horizontalLine(),
                    Text(
                      'or',
                      style: TextStyle(color: Colors.white),
                    ),
                    horizontalLine()
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Sign Up (New user)',
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  color: Colors.blueGrey,
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
