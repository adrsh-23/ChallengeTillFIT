import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('homePage')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                //! here add route to home page
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                //! here add route to the page to add post or challenge other user
              },
            ),
            label: 'add',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                Icons.notifications_active_outlined,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                // ! here add route to notification page
              },
            ),
            label: 'notification',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                //!here add route to profile page
              },
            ),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
