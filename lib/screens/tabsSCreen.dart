import 'package:flutter/material.dart';
import 'package:memo/screens/crypto.dart';
import 'package:memo/screens/jamScreen.dart';
import 'package:memo/screens/tech.dart';

class TabssScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('NewFeed', style: TextStyle(color: Colors.white),),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromRGBO(0, 0, 71, 1),
            tabs: [
            Tab(text: 'Business',),
            Tab(text:'Technology'),
            Tab(text: 'General',) 
          ]),
        ),

        body: TabBarView(children: [
          JamScreen(),
          TechScreen(),
          CryptoScreen()
        ]),
      ),
    );
  }
}