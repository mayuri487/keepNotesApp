import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Provider/noteList.dart';
import './Scrrens/addNote.dart';
import './Scrrens/tabsScreen.dart';
import './Provider/check_list.dart';
import './Provider/reminderList.dart';
import './Scrrens/addReminderScree.dart';
import './Provider/theme.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context) => NotesList(),
      ),
      ChangeNotifierProvider(
        create: (context) => CheckItemList(),
        ),
           ChangeNotifierProvider(
        create: (context) => ReminderList(),
        ),
        ChangeNotifierProvider(create: (context) => ThemeChanger(ThemeData.dark()))
        ],
          child: MaterialappWithTheme());
    
  }
}

class MaterialappWithTheme extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
        home: TabsScreen(),
        theme: theme.getTheme(),
        routes: {
    '/addNotesScreen': (context) => AddNotesScreen(),
    '/addReminder': (context) => AddReminderScreen(),
    '/tabsScreen': (context) => TabsScreen(),
    
        },
    );
  }
}

