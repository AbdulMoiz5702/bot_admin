


import 'package:bot_admin/views/academic-tasks_screens/academic_tasks.dart';
import 'package:bot_admin/views/all_tasks_screen/All_tasks_screen.dart';
import 'package:flutter/material.dart';

import '../daily_tasks_screen/daily_tasks_screen.dart';
import '../social_tasks_screen/social_tasks_screen.dart';

class BottomScreen extends StatefulWidget {

  const BottomScreen();

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen>  {
   int indexx = 0;
   List<Widget>screens = [
   AllTasksScreen(),
     SocialTaksScreen(),
     DailyTasksScreen(),
     AcademicTasksScreen(),
   ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[indexx],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: indexx,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10.0,
        unselectedFontSize: 8.0,
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        unselectedIconTheme: const IconThemeData(color: Colors.black26),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black26,
        onTap: (index) {
          indexx = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.public_outlined), label: 'All Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Social Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.groups_2_outlined), label: 'Daily Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Academic Tasks'),
        ],
      ),
    );
  }
}