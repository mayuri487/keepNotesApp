
import 'package:flutter/material.dart';

import '../Scrrens/homePage.dart';
import '../Scrrens/checkListScreen.dart';
import '../Scrrens/reminderScreen.dart';

class TabsScreen extends StatefulWidget {
  

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
   with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: TabBarView(
          controller: _tabController,
          children: [
            MyHomePage(),
   
           CheckListScreen(),
           
            ReminderScreen(),
         
          ],
        ),
      ),
      bottomNavigationBar: TabBar(
       controller: _tabController,
        labelStyle: Theme.of(context).textTheme.button,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          Tab(
            text: 'Home',
          ),
          Tab(
            text: 'Check List',
          ),
          Tab(
            text: 'Reminders',
        
          )],
      ),
    );
  }
}