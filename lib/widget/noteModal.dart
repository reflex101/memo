import 'package:flutter/material.dart';
import 'package:memo/models/note.dart';
import 'package:memo/provider/noteProvider.dart';
import 'package:provider/provider.dart';

// enum NoteMode { Editing, Adding }

class NoteModal extends StatefulWidget {
  // final NoteMode _noteMode;

  // NoteModal(this._noteMode,);

  static const routeName = '/note-modal';
  @override
  _NoteModalState createState() => _NoteModalState();
}

class _NoteModalState extends State<NoteModal> {
  final GlobalKey<FormState> _formKey = GlobalKey();
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

  void _submitNote() {
    // if(widget._noteMode == NoteMode.Adding){
    _formKey.currentState.save();

    if (_editedNotes.id != null) {
      Provider.of<Notes>(context, listen: false).updateNotes(_editedNotes.id, _editedNotes);
    } else {
      Provider.of<Notes>(context, listen: false).addNotes(_editedNotes);
      
    }
    Navigator.of(context).pop();
    // }

    //  else if(widget._noteMode == NoteMode.Editing){

    //  }
  }

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
            IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
            IconButton(icon: Icon(Icons.music_note), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.save_alt),
              onPressed: _submitNote,
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
        bottomNavigationBar: Container(
          height: 50.0,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: <Widget>[],
          ),
        ));
  }
}
