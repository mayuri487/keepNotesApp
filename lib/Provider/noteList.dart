import 'package:flutter/cupertino.dart';

import './Notes.dart';

class NotesList with ChangeNotifier {
  List<Notes> _notesList = [
  /*  Notes(
        id: DateTime.now().toString(),
        title: 'Flutter',
        content: 'make new project'),
    Notes(
        id: DateTime.now().toString(),
        title: 'quote',
        content: 'be your own sunshine!'),*/
  ];

  
  List<Notes> get notesList {
    return [..._notesList];
  }

   List<Notes> get starred {
    return _notesList.where((note) => note.isPinned).toList();
  }

  Notes findById(String id) {
    return _notesList.firstWhere((note) => note.id == id);
  }

  void addNotes(Notes note) {
    final newNote = Notes(
      id: DateTime.now().toString(),
      content: note.content,
      title: note.title,
      datetime: DateTime.now()
    );
    _notesList.insert(0, newNote);
    notifyListeners();
  }

  void deleteNote(String id){
    _notesList.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void updateNote(String id, Notes newNote) {
    final noteIndex = _notesList.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      _notesList[noteIndex] = newNote;
      notifyListeners();
    } else {
      print('...');
    }
  }
}