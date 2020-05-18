import 'package:flutter/material.dart';

import 'package:memo/screens/boxScreen.dart';


import 'package:memo/screens/noteOverview.dart';
import 'package:memo/screens/tabsSCreen.dart';
import 'package:memo/widget/noteModal.dart';

class Navigation extends StatefulWidget {
  static const routeName = '/navigation';
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final List<Widget> _pages = [
    NoteOverview(),
    TabssScreens(),
    BoxScreen(),
  ];
  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    
  // void noteModal(){
  //     showModalBottomSheet(
  //       isDismissible: true,
  //       enableDrag: true,
        
  //       context: context, builder: (ctx) => Container(
  //       height: MediaQuery.of(context).size.height/2 + 200.0,
  //       width: double.infinity,
  //       color: Colors.red,
  //     ));
  //   }
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: _pages[_selectedIndex],

      floatingActionButton: FloatingActionButton(onPressed:(){
       Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => NoteModal( storage: Storage(),)));
      }, child: Icon(Icons.add, size: 30.0,color: Color.fromRGBO(0, 0, 71, 1),),),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        // type: BottomNavigationBarType.fixed,
        onTap: _selectedPage,
        currentIndex: _selectedIndex,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.web), title: Text('NewFeed')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('Box')),
        ],
      ),
    );
  }
}
