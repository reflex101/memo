import 'package:flutter/cupertino.dart';

class Note with ChangeNotifier{
  final String id;
  final String title;
  final String description;

  Note({this.id, this.title, this.description});
} 