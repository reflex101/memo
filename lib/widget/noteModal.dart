import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memo/models/note.dart';
import 'package:memo/provider/noteProvider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
// enum NoteMode { Editing, Adding }

class NoteModal extends StatefulWidget {
  // final NoteMode _noteMode;
  final Storage storage;
  NoteModal({Key key, @required this.storage}) : super(key: key);
  // NoteModal(this._noteMode,);

  static const routeName = '/note-modal';
  @override
  _NoteModalState createState() => _NoteModalState();
}

class _NoteModalState extends State<NoteModal> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String state;
  Future<Directory> _appDocDir;

  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  var _editedNotes = Note(
    id: null,
    title: '',
    description: '',
  );
  var _initValues = {'title': '', 'description': ''};
  var _isInit = true;
  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((value) {
      state = value;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final noteId = ModalRoute.of(context).settings.arguments as String;
      if (noteId != null) {
        _editedNotes = Provider.of<Notes>(context).findbyId(noteId);
        _initValues = {
          'title': _editedNotes.title,
          'description': _editedNotes.description
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

 
    // if(widget._noteMode == NoteMode.Adding){
    Future<File> writeData(){
      

    setState(() {
       _formKey.currentState.save();
  if (_editedNotes.id != null) {
      Provider.of<Notes>(context, listen: false)
          .updateNotes(_editedNotes.id, _editedNotes);
    } else {
      Provider.of<Notes>(context, listen: false).addNotes(_editedNotes);
      Navigator.of(context).pop();
    }
      
    });
    return widget.storage.writeData(state);
     
    } 
   
    // }

    //  else if(widget._noteMode == NoteMode.Editing){

    //  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 2,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          // widget._noteMode == NoteMode.Adding
          'Write it or Edit it',
          style: TextStyle(color: Color.fromRGBO(0, 0, 71, 1)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: writeData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _initValues['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                        decoration: InputDecoration(
                          hintText: 'HEADER',
                          hintStyle: TextStyle(fontSize: 20.0),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        // controller: titleController,
                        onSaved: (value) {
                          _editedNotes = Note(
                            title: value,
                            description: _editedNotes.description,
                            id: _editedNotes.id,
                          );
                        },
                      ),
                      Divider(),
                      TextFormField(
                          initialValue: _initValues['description'],
                          decoration: InputDecoration(
                            hintText: 'BODY',
                            hintStyle: TextStyle(fontSize: 20.0),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          // controller: bodyController,
                          onSaved: (value) {
                            _editedNotes = Note(
                              title: _editedNotes.title,
                              description: value,
                              id: _editedNotes.id,
                            );
                          }),
                    ],
                  )),
            ),
            // Container(
            //   height: 50.0,
            //   width: double.infinity,
            //   color: Theme.of(context).primaryColor,
            // )
          ],
        ),
      ),
    );
  }
}

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String title) async {
    final file = await localFile;
    return file.writeAsString('$title');
  }
}
