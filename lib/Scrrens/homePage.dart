import 'package:flutter/material.dart';
import '../Provider/theme.dart';
//import 'package:notes_app/Provider/Notes.dart';
import 'package:provider/provider.dart';
//import '../widget/noteItem.dart';
import '../Provider/noteList.dart';
import '../widget/ItemList.dart';

enum Filter { Starred, All }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var showStarred = false;
  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<NotesList>(context);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    //final notes = _showStarred ? notesData.starred : notesData.notesList;

    return Scaffold(
      drawer: Drawer(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              ListTile(
                leading: CircleAvatar(child:Text('M'),
                
                ),
                title: Text('Mayuri')
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Theme Setting', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  onPressed: () => _themeChanger.setTheme(ThemeData.dark()),
                  child: Text('Dark Theme')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  onPressed: () => _themeChanger.setTheme(ThemeData.light()),
                  child: Text('Light Theme')),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Add Note',
        // style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        //backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          PopupMenuButton(
              onSelected: (Filter selectedValue) {
                setState(() {
                  if (selectedValue == Filter.Starred) {
                    showStarred = true;
                  } else {
                    showStarred = false;
                  }
                  print(selectedValue);
                });
              },
              icon: Icon(
                Icons.more_vert,
                //color: Colors.blue,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('only starred'),
                    value: Filter.Starred,
                  ),
                  PopupMenuItem(child: Text('show all'), value: Filter.All)
                ];
              })
        ],
      ),
      body: notesData.notesList.isEmpty
          ? Center(child: Text('No notes added yet.'))
          : ItemList(showStarred),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/addNotesScreen');
        },
      ),
    );
  }
}
