import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/reminderList.dart';
import '../widget/reminderItem.dart';
//import '../Provider/reminder.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
 
  @override
  Widget build(BuildContext context) {
     final reminderData = Provider.of<ReminderList>(context);
     //final reminder = Provider.of<Reminder>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a reminder',
           // style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        //backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:  reminderData.reminderList.isEmpty ? Center(child: Text('No reminders added yet.'),) :  ListView.builder(itemCount: reminderData.reminderList.length,
      itemBuilder: (_, i){
        return ChangeNotifierProvider.value(value: reminderData.reminderList[i],
        child: ReminderItem()
          
        );
      },
      ),
      
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).pushNamed( '/addReminder');
      },
      child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    
              
                 
        
      
  
  }
}
