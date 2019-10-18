import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
class Loginpage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn,
}

class LoginPageState extends State<Loginpage> with SingleTickerProviderStateMixin{

  AuthStatus authStatus = AuthStatus.notSignedIn;
  String phoneNo;
  String smsCode;
  String verificationId;
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String signedPhone;
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  getUser(String phone) async{
      ///fetch user from API according to his phone number
  }

  signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);
    smsCode = '';
  }

  Future<bool> smsCodeDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text('Enter the OTP'),
            content: TextField(
              onChanged: (value){
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                  onPressed: (){
                    FirebaseAuth.instance.currentUser().then((user){
                      if(user != null){
                        Navigator.of(context).pop();
                      }
                      else{
                        Navigator.of(context).pop();
                        signIn(smsCode);
                      }
                    });
                  },
                  child: Text('Done')
              )
            ],
          );
        }
    );
  }

  @override
  void initState(){
    FirebaseAuth.instance.currentUser().then((userId){
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        if(userId != null){
          List newPh = userId.phoneNumber.split("+91");
          signedPhone = newPh[1];
          getUser(signedPhone);
        }
      });
    });
    myController.text = '+91';
    super.initState();
    _iconAnimationController = new AnimationController
      (vsync: this,
        duration: new Duration(microseconds: 500)
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeOut
    );
    _iconAnimation.addListener(()=> this.setState((){}));
    _iconAnimationController.forward();
  }

    Future<void> verifyPhone() async{
      String phone = myController.text;
      String searchPhone = myController.text;
      List newPh = searchPhone.split("+91");
      String sendPhone = newPh[1];
      print(sendPhone);
      print(phone);
      // _onLoading();
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
        this.verificationId = verId;
      };
      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){

        this.verificationId = verId;
        smsCodeDialog(context).then((value){
          getUser(sendPhone);
          print('Signed In');
        });
      };

      final PhoneVerificationCompleted verifiedSuccess = (AuthCredential credential){
          // print(credential);
          getUser(sendPhone);
          print('Verified');
      };
      final PhoneVerificationFailed failed = (AuthException exception){
        print('${exception.message}');
      };
      await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: phone, timeout: const Duration(seconds: 5), verificationCompleted: verifiedSuccess, verificationFailed: failed, codeSent: smsCodeSent, codeAutoRetrievalTimeout: autoRetrieve);
    }

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
                  controller: myController,
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
              onPressed: (){
                  verifyPhone();
                
              },
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
