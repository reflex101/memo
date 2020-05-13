import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo/models/note.dart';
import '';
class Notes with ChangeNotifier {
  List<Note> _noteItems = [
    Note(
      id: 'n1',
      title: 'Bigman joe',
      description:
          'You can query the Firebase Auth backend through a REST API. This can be used for various' 
          'operations such as creating new users, signing in existing ones and editing or deleting'
          'these users. Throughout this document, API_KEY refers to the Web API Key,',
    ),
    Note(
      id: 'n1',
      title: 'Bigman joe',
      description:
          'You can query the Firebase Auth backend through a REST API. This can be used for various' 
          'operations such as creating new users, signing in existing ones and editing or deleting'
          'these users. Throughout this document, API_KEY refers to the Web API Key,',
    ),
    
  ];

  List<Note> get noteItems {
    return _noteItems;
    
  }
    void addNotes(Note note){
      final noteBody = Note(
        id: DateTime.now().toString(),
        title: note.title,
        description: note.description
      );
      
      _noteItems.add(noteBody);
      notifyListeners();
    }
 
  int sumOfNotes(){

    if(_noteItems.isNotEmpty){
      return _noteItems.length;
    }
    return 0;
  } 

  Note findbyId(String id){
    return _noteItems.firstWhere((note) => note.id == id);
  }

  void updateNotes(String id, Note newNotes){
    final noteData = _noteItems.indexWhere((note) => note.id == id);
    if(noteData >= 0){
      _noteItems[noteData] = newNotes;
    }
    
    notifyListeners();
  }
}
