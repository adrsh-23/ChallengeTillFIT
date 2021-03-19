import 'package:ctf_app/pages/dashboard/dashboard.dart';
import 'package:ctf_app/pages/profilePage/profilePage.dart';
import 'package:ctf_app/pages/uploadPage/upload.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _Page = <Widget>[
    Dashboard(),
    UploadPage(),
    Text('notification Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: Colors.grey,
              size: 30,
            ),
            label: 'add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Colors.grey,
              size: 30,
            ),
            label: 'notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.grey,
              size: 30,
            ),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
