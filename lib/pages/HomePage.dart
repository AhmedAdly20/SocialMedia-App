import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSignedIn = false;

  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((googleSignInAccount) {
      controlSignIn(googleSignInAccount);
    }, onError: (gError) {
      print('Error: ' + gError);
    });

    googleSignIn.signInSilently(suppressErrors: false).then(
      (googleSignInAccount) {
        controlSignIn(googleSignInAccount);
      },
    ).catchError((gError) {
      print('Error: ' + gError);
    });
  }

  controlSignIn(GoogleSignInAccount googleSignInAccount) async {
    if (googleSignInAccount != null) {
      setState(() {
        isSignedIn = true;
      });
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  loginUser() {
    googleSignIn.signIn();
  }

  logoutUser(){
    googleSignIn.signOut();
  }

  Widget buildHomeScreen() {
    return RaisedButton.icon(
      onPressed: logoutUser,
      label: Text('Sign Out'),
      icon: Icon(Icons.close),
    );
  }

  Widget buildSignInScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor
              ]),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Instagram',
              style: TextStyle(
                fontSize: 92.0,
                color: Colors.white,
                fontFamily: "Signatra",
              ),
            ),
            GestureDetector(
              onTap: loginUser,
              child: Container(
                width: 270,
                height: 65.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/google_signin_button.png'),
                  fit: BoxFit.cover,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return buildSignInScreen();
    }
  }
}
