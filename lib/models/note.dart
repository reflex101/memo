import 'package:flutter/cupertino.dart';

enum Catgories{
  School,
  Work,
  Personal,
  Versatile
}
class Note with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final Catgories category;
  Note({this.id, this.title, this.description, this.category});
} 