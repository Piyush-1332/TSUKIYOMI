import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'start_page.dart';
import 'package:dotted_border/dotted_border.dart';

class Loginpage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class LoginPageState extends State<Loginpage>
    with SingleTickerProviderStateMixin {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  String phoneNo;
  String smsCode;
  String verificationId;
  dynamic user_details;

  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String signedPhone;
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  getUser(String phone) async {
    http.Response user = await http.post(
        Uri.encodeFull("https://tsukiyomi.herokuapp.com/api/user/create"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
          "phone": phone
        });
    if (user.statusCode == 200) {
      print(user.body);
    }
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => new Start(phone: phone),
    );
    Navigator.pop(context);
    Navigator.of(context).push(route);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(phone, phone);

    ///fetch user from API according to his phone number
  }

  signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final FirebaseUser user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);
    smsCode = '';
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter the OTP'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser().then((user) {
                      if (user != null) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        signIn(smsCode);
                      }
                    });
                  },
                  child: Text('Done'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        if (userId != null) {
          List newPh = userId.phoneNumber.split("+91");
          signedPhone = newPh[1];
          getUser(signedPhone);
        }
      });
    });
    myController.text = '+91';
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(microseconds: 500));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new CircularProgressIndicator(),
        ],
      ),
    );
  }

  getPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("phone");
  }

  Future<void> verifyPhone() async {
    String phone = myController.text;
    String searchPhone = myController.text;
    List newPh = searchPhone.split("+91");
    String sendPhone = newPh[1];
    print(sendPhone);
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        getUser(sendPhone);
        print('Otp Login');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential credential) {
      // print(credential);
      _onLoading();
      getUser(sendPhone);
      print('Auto Logged In');
    };
    final PhoneVerificationFailed failed = (AuthException exception) {
      print('${exception.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: failed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
  }

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
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return Scaffold(
          body: Container(
              child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image(
                image: new AssetImage("assets/bg1.png"),
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 70.0),
                  ),
                  Container(
                    child: Text('Tsukiyomi',
                        style: TextStyle(
                            fontFamily: 'Mozart',
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screensize.height - 600),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 80.0, right: 80.0),
                      child: DottedBorder(
                          dashPattern: [8, 3, 2, 3],
                          strokeWidth: 2.0,
                          color: Colors.red[900],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: TextField(
                                controller: myController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Phone',
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    color: Colors.red,
                                  ),
                                ),
                                obscureText: false,
                              ))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  new RaisedButton(
                    onPressed: () {
                      print(verifyPhone());
                    },
                    padding: EdgeInsets.only(),
                    color: Colors.red[900],
                    child:
                        Text('Sign in', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          )),
        );
      case AuthStatus.signedIn:
        return Start(phone: getPhone());
    }
  }
}
