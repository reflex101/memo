import 'package:flutter/material.dart';
import 'package:memo/provider/noteProvider.dart';
import 'package:memo/widget/noteModal.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoteDetails extends StatelessWidget {
  static const routeName = '/note-de';
  final String id;
  final String title;
  final String body;

  NoteDetails(this.id, this.title, this.body);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Note Overview',
          style: TextStyle(color: Color.fromRGBO(0, 0, 71, 1)),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(NoteModal.routeName, arguments: id);

                // Navigator.of(context).pop();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Created on',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 71, 1),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(DateFormat.yMMMMEEEEd()
                        .format(DateTime.now())
                        .toString()),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                )
              ],
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 71, 1)),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              body,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Notes>(context, listen: false).removeNote(id);
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.delete,
          color: Color.fromRGBO(0, 0, 71, 1),
        ),
      ),
    );
  }
}
