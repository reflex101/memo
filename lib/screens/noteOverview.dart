import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memo/provider/auth.dart';
import 'package:memo/provider/noteProvider.dart';

import 'package:memo/widget/noteItem.dart';
import 'package:provider/provider.dart';

class NoteOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notee = Provider.of<Notes>(context);
    final noteInfo = notee.noteItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MEMO',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Header(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  // Text(
                  //   'Category',
                  //   style:
                  //       TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left:20.0),
                  //   child: Container(
                  //     height: 200.0,
                  //     width: double.infinity,
                  //     child: ListView.builder(
                  //       itemCount: 4,
                  //       itemBuilder: (ctx, i) => Category(),
                  //       scrollDirection: Axis.horizontal,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Notes',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.45,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: noteInfo.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      child: NoteItem(noteInfo[i].id, noteInfo[i].title,
                          noteInfo[i].description),
                      value: noteInfo[i],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sumOfNotes = Provider.of<Notes>(context).sumOfNotes();
    
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, AsyncSnapshot<FirebaseUser> snapshot){
      return  Row(
      children: <Widget>[
        Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 2.0),
            image: DecorationImage(
              image: NetworkImage(snapshot.hasData != null ? snapshot.data.photoUrl :  null ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(child: Text(snapshot.data.displayName, style: TextStyle(fontSize:20.0, fontWeight:FontWeight.bold),)),
        Text(
          '${_sumOfNotes.toString().toUpperCase()} notes',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
      ],
    );
    });
  }
}
