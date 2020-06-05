import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/noteList.dart';
import '../widget/noteItem.dart';

class ItemList extends StatelessWidget {
  final bool showStarred;
  ItemList(this.showStarred);

  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<NotesList>(context);
    final notes = showStarred ? notesData.starred : notesData.notesList;

    return ListView.builder(itemCount: notes.length,
      itemBuilder: (ctx, i){
        return
         ChangeNotifierProvider.value(
          value: notes[i],
          child: NoteItem());
      },
      );
  }
}