import 'package:flutter/material.dart';
import 'package:memo/provider/auth.dart';
import 'package:memo/provider/noteProvider.dart';
import 'package:provider/provider.dart';
import 'authScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BoxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final numberNotes = Provider.of<Notes>(context).sumOfNotes();

    var _isImage = true;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.data != null) {
            return Column(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0),
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Color.fromRGBO(0, 0, 71, 1), width: 2.0),
                      image: DecorationImage(
                          image: NetworkImage(snapshot.hasData
                              ? snapshot.data.photoUrl
                              : 'lib/assets/sea.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: _isImage
                        ? Container()
                        : IconButton(
                            icon: Icon(Icons.person_add), onPressed: () {}),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  snapshot.hasData ? snapshot.data.displayName : null,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 71, 1)),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  snapshot.hasData ? snapshot.data.email : null,
                  style: TextStyle(fontSize: 17.0),
                ),
                RichText(
                  text: TextSpan(
                      text:
                          '${snapshot.hasData ? snapshot.data.displayName : 'Unknown'} has written ',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: numberNotes.toString(),
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Color.fromRGBO(0, 0, 71, 1))),
                        TextSpan(text: ' notes')
                      ]),
                ),
                RaisedButton(
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).signOutGoogle();

                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routeName);
                  },
                  child: Text('log out'),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
