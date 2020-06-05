import 'package:flutter/cupertino.dart';

class Notes with ChangeNotifier {
  final String id;
  final String title;
  final String content;
   final DateTime datetime;
   bool isPinned;

  Notes({
    this.id,
    this.title,
    this.content,
     this.datetime,
     this.isPinned = false
  });

  void toggleStar(){
    isPinned =! isPinned;
    notifyListeners();
  }

}


