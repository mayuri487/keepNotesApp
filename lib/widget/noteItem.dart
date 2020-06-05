import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/Notes.dart';
import '../Provider/noteList.dart';

class NoteItem extends StatelessWidget {
  // final Notes notes;
  // NoteItem(this.notes);

  @override
  Widget build(BuildContext context) {
    final noteData = Provider.of<Notes>(context);
    final notesData = Provider.of<NotesList>(context, listen: false);

    return Dismissible(
      key: ValueKey(noteData.id),
      background: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          alignment: Alignment.centerRight,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        notesData.deleteNote(noteData.id);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to delete this note?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes')),
            ],
          ),
        );
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed('/addNotesScreen', arguments: noteData.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      noteData.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(noteData.content),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edited. ${DateFormat('dd/MM/yyyy hh:mm').format(noteData.datetime)}',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        IconButton(
                            onPressed: () {
                              noteData.toggleStar();
                            },
                            icon: Icon(noteData.isPinned
                                ? Icons.star
                                : Icons.star_border))
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
