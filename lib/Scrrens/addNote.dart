import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import '../Provider/Notes.dart';
import 'package:provider/provider.dart';
import '../Provider/noteList.dart';

class AddNotesScreen extends StatefulWidget {
  @override
  _AddNotesScreenState createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final _contentFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedNote =
      Notes(id: null, title: '', content: '', datetime: DateTime.now());
                        
  var _isInit = true;
  var _initValue = {
    'title': '',
    'content': '',
  };

  @override
  void dispose() {
    final _contentFocusNode = FocusNode();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final noteId = ModalRoute.of(context).settings.arguments as String;
      if (noteId != null) {
        _editedNote =
            Provider.of<NotesList>(context, listen: false).findById(noteId);
        _initValue = {
          'title': _editedNote.title,
          'content': _editedNote.content
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if(!isValid){
      return;
    }
    _form.currentState.save();
    if (_editedNote.id != null) {
      Provider.of<NotesList>(context, listen: false)
          .updateNote(_editedNote.id, _editedNote);
    } else {
      Provider.of<NotesList>(context, listen: false).addNotes(_editedNote);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //final notesData = Provider.of<NotesList>(context);

    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  _saveForm();
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _form,
            child: ListView(children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_contentFocusNode);
                },
                onSaved: (value) {
                  _editedNote = Notes(
                      title: value,
                      content: _editedNote.content,
                      id: _editedNote.id,
                      datetime: DateTime.now(),
                      isPinned: _editedNote.isPinned
                      );
                },
                initialValue: _initValue['title'],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Note'),
                textInputAction: TextInputAction.done,
                focusNode: _contentFocusNode,
                validator: (val){
                  if(val.isEmpty){
                    return 'Please enter a note';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                onSaved: (value) {
                  _editedNote = Notes(
                      title: _editedNote.title,
                      content: value,
                      id: _editedNote.id,
                       datetime: DateTime.now(),
                       isPinned: _editedNote.isPinned
                       );
                },
                initialValue: _initValue['content'],
              )
            ]),
          ),
        ));
  }
}
