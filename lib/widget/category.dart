import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/noteProvider.dart';

class Category extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2/2.6,
      child: Container(
        margin: EdgeInsets.only(right:10.0),
        height: 200.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Text('Hello'),
               Text('hello'),
               Text('hello') 
            ],
          ),
        ),
      ),
    );
  }
}