import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../Provider/reminder.dart';
import '../Provider/reminderList.dart';


class ReminderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final reminder = Provider.of<Reminder>(context);
      final reminderData = Provider.of<ReminderList>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              alignment: Alignment.centerRight,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction){
              reminderData.removeReminder(reminder.id);
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('One item deleted'),
               
                )
              );
            },
              child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(reminder.title, style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(reminder.content),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.alarm),
              ),
              Text(DateFormat.yMMMMEEEEd().format(reminder.date)),
              SizedBox(width: 10),
              Text('${reminder.time.hour}:${reminder.time.minute}')
            ],)
          ],),
          
        ),
      ),
    );
  }
}