import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<Loginpage> {

    Widget horizontalLine() =>
      Padding(
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
              child: Text('Tsukiyomi',style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold,color: Colors.white54)),
            ),
            SizedBox(
              height: screensize.height/14,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: TextField(
                  style: TextStyle(color: Theme.of(context).accentColor),
                  decoration: InputDecoration(
                    hintText: 'Email-Id',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    prefixIcon: const Icon(
                      Icons.email,
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
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    //Add th Hint text here.
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
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            new RaisedButton(
              onPressed: (){},
              padding: EdgeInsets.only(),
              color: Colors.white,
              child: Text('Sign in', style:TextStyle(color: Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[horizontalLine(),
                    Text('or'),horizontalLine()
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
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.email),
                      Expanded(
                        child: Text('Sign Up with Gmail',
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
            Container(
              child: Padding(
                  padding: EdgeInsets.only(),
                  child: RaisedButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.favorite),
                        Expanded(
                          child: Text('Facebook',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    color: Color(0xFF3C5A99),
                    onPressed: () {},
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
