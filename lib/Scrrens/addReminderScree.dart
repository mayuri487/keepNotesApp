import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/reminder.dart';
import '../Provider/reminderList.dart';

class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final titleController = TextEditingController();

  final contentController = TextEditingController();

  DateTime selectedDate;
  TimeOfDay selectedTime;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time) {
      if (time == null) {
        return;
      }
      setState(() {
        selectedTime = time;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final reminderData = Provider.of<ReminderList>(context);
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Add Reminder')),
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'content'),
                controller: contentController,
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedDate == null
                      ? 'No date chosen'
                      : 'Picked date : ${DateFormat.yMMMMEEEEd().format(selectedDate)}'),
                  RaisedButton(
                      onPressed: _presentDatePicker, child: Text('Choose date'))
                ],
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedTime == null
                      ? 'No time chosen'
                      : 'Picked Time : ${selectedTime.hour}:${selectedTime.minute}'),
                  RaisedButton(
                    onPressed: _presentTimePicker,
                    child: Text('Choose time'),
                  )
                ],
              ),
              SizedBox(height: 30),
              RaisedButton(
                  onPressed: () {
                    if(contentController.text.isEmpty && titleController.text.isEmpty){
                      return;
                    }else{
                    reminderData.addReminder(Reminder(
                    content: contentController.text,
                    title: titleController.text,
                    date: selectedDate,
                    time: selectedTime,
                    id: DateTime.now().toString()
                        ));
                    Navigator.of(context).pop();}
                  },
                  child: Text('Save'))
            ],
          ),
        ));
  }
}
