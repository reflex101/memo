import 'package:flutter/material.dart';
import 'package:memo/models/note.dart';
import 'package:memo/widget/noteModal.dart';
import 'package:provider/provider.dart';
import '../widget/noteModal.dart';

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String body;

  NoteItem(this.id, this.title, this.body);
  @override
  Widget build(BuildContext context) {
    // final noteData = Provider.of<Note>(context);
    return Container(
      height: 150.0,
      child: Card(
        elevation: 1.0,
        shadowColor: Colors.grey[200],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 13.0, bottom: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 71, 1)),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                body,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.mode_edit,
                        color: Color.fromRGBO(0, 0, 71, 1),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(NoteModal.routeName, arguments: id);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
