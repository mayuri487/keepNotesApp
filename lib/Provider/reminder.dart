import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reminder with ChangeNotifier{
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final TimeOfDay time;

  Reminder({this.title, this.content, this.date, this.time, this.id});



}

