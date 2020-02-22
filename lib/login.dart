import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'start_page.dart';

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
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String signedPhone;
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  getUser(String phone) async {
    print(phone);

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
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(microseconds: 500));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  Future<void> verifyPhone() async {
    String phone = myController.text;
    String searchPhone = myController.text;
    List newPh = searchPhone.split("+91");
    String sendPhone = newPh[1];
    print(sendPhone);
    print(phone);
    // _onLoading();
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        getUser(sendPhone);
        print('Signed In');
        Navigator.pop(context);
        Navigator.of(context).pushNamed('/home');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential credential) {
      // print(credential);
      getUser(sendPhone);
      print('Verified');
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
    print(authStatus);
    if (authStatus == AuthStatus.signedIn) {
      return Start();
    }
    return Scaffold(
      body: Container(
          child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: new AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text('Tsukiyomi',
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              SizedBox(
                height: screensize.height / 14,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(),
                  child: TextField(
                    controller: myController,
                    style: TextStyle(color: Theme.of(context).accentColor),
                    decoration: InputDecoration(
                      hintText: 'Email-Id',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    obscureText: false,
                  ),
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
                color: Colors.white,
                child: Text('Sign in', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
