import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'darkTheme.dart';
import 'Setting.dart';

class BottomNav extends StatefulWidget {

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Setting(),

  ];


  @override
  Widget build(BuildContext context) {

    return Container(

            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              backgroundColor: Color(0xFF3250E7),
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.orange,

              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 40,
                  ),
                  label: 'MENU',
                  tooltip: 'Menu',

                ),
                BottomNavigationBarItem(
                    icon: Icon(
                         Icons.event_note_sharp,
                      size: 40,
                    ),
                    label: 'NOTES',
                    tooltip: 'Notes'),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.notifications,
                      size: 40,
                    ),
                    label: 'Notification',
                    tooltip: 'Notification'),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.mic,
                    size: 40,
                  ),
                  label: 'home',
                  tooltip: 'Home',
                )
              ],
              onTap: (index){
                setState(() {
                  _selectedIndex =index;
                });
              },

              type: BottomNavigationBarType.fixed,
              iconSize: 50,
              selectedFontSize: 16.0,
              unselectedFontSize: 16.0,
            )

    );

  }
}
