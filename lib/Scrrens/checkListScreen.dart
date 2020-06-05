import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/check_list.dart';

class CheckListScreen extends StatefulWidget {
  @override
  _CheckListScreenState createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data =  Provider.of<CheckItemList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My List - ${data.checkBoxList.length} items',
         // style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
        //backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:
      ListView.builder(itemBuilder: (_, i){
        return  Dismissible(
          key: UniqueKey(),
          onDismissed: (direction){
            data.removeItem(i);
          },
          background: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.delete),
            ),
            alignment: Alignment.centerRight,
          ),
          direction: DismissDirection.endToStart,
                  child: CheckboxListTile(
                title: Text(data.checkBoxList[i].title),
                value: data.checkBoxList[i].status,
                onChanged: (newValue) {
                  setState(() {
                    data.checkBoxList[i].status = newValue;
                  });
                }),
        );
      },
      itemCount: data.checkBoxList.length,
      ),
     
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Item'
                        ),
                        controller: _inputController,
                      ),
                    ),
                    SizedBox(height: 30),
                    RaisedButton(
                      child: Text('Add'),
                      onPressed: () {
                        if(_inputController.text.isEmpty){
                          return;
                        }
                        data
                            .addItem(CheckItem(_inputController.text, false));
                            Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
