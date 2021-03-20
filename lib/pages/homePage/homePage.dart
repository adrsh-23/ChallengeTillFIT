import 'package:ctf_app/pages/dashboard/dashboard.dart';
import 'package:ctf_app/pages/notificationPage/notificationPage.dart';
import 'package:ctf_app/pages/profilePage/profilePage.dart';
import 'package:ctf_app/pages/searchPage/searchPage.dart';
import 'package:ctf_app/pages/uploadPage/upload.dart';
import 'package:ctf_app/pages/uploadPage/uploadMainPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _Page = <Widget>[
    Dashboard(),
    Search(),
    NotificationPage(),
    ProfilePage(),
  ];
  void changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _Page.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        onTap: changePage,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: false,
        backgroundColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.tealAccent,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.tealAccent,
              size: 30,
            ),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Colors.tealAccent,
              size: 30,
            ),
            label: 'notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.tealAccent,
              size: 30,
            ),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
