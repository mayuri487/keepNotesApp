import './reminder.dart';

import 'package:flutter/cupertino.dart';

class ReminderList with ChangeNotifier{

List<Reminder> _reminderList =[];

List<Reminder> get reminderList{
  return [..._reminderList];
  
} 

void addReminder(Reminder reminder){
  _reminderList.insert(0, reminder);
  
  
}

void removeReminder( String id){
 _reminderList.removeWhere((reminder) => reminder.id == id);
  notifyListeners();
}

}