import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:memo/provider/auth.dart';
import 'package:memo/widget/tabBar.dart';
import 'package:provider/provider.dart';
// import 'package:memo/models/httpException.dart';
// import 'package:memo/provider/auth.dart';
// import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor.withOpacity(1),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top:100.0),
              child: Text(
                'Memo',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 71, 1) ),
              ),
            ),
          
          Padding(
              padding: const EdgeInsets.only(top:10.0, right: 10.0, left: 10.0),
              child: Text(
                'Write, get the latest news in Business, Technology & Cryptocurrency',
                style: TextStyle(fontSize: 20.0, color: Colors.grey[500],),textAlign: TextAlign.center,
              ),
            ),
          SizedBox(height: 20.0,),
          AuthDetails()
        ],
      )),
    );
  }
}

class AuthDetails extends StatefulWidget {
  const AuthDetails({
    Key key,
  }) : super(key: key);

  @override
  _AuthDetailsState createState() => _AuthDetailsState();
}

class _AuthDetailsState extends State<AuthDetails> {
  var _isloading = true;
  
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<Auth>(context).signInWithGoogle();
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              // SizedBox(height: 50,),
              GestureDetector(
                onTap: () {
                  login.whenComplete(
                      () => Navigator.of(context).pushReplacementNamed(
                            Navigation.routeName,
                          ));
                },
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).primaryColor,
                        Color.fromRGBO(0, 0, 71, 1)
                      ])),
                  child: Center(
                      child: Text(
                    'SIGIN WITH GOOGLE',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              )
            ]));
  }
}
