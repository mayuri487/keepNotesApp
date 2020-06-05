import 'package:flutter/cupertino.dart';

class CheckItem {
  final String title;
  bool status;
  
  //final String id;

  CheckItem(this.title, this.status);

}

class CheckItemList with ChangeNotifier{
    List<CheckItem> _checkBoxList = [
      
    ];

    List<CheckItem> get checkBoxList{
      return [..._checkBoxList];
    }

    void addItem(CheckItem item){
      _checkBoxList.insert(0, item);
      notifyListeners();

    
    }

    void removeItem(int index){
      _checkBoxList.removeAt(index);
      notifyListeners();
    }

}