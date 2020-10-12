import 'package:DevOps_Board/Dashboard_helpers/create_new_task_page.dart';
import 'package:DevOps_Board/Dashboard_helpers/task_list.dart';
import 'package:DevOps_Board/createNewTask.dart';
import 'package:DevOps_Board/dashboard.dart';
import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:DevOps_Board/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen;
  final List<Widget> screens = <Widget>[
    Dashboard(),
    CreateNewTask(),
    UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          // body: PageStorage(
        // bucket: bucket,
        body:Center(
          child: screens.elementAt(_selectedIndex),
        ), 
        bottomNavigationBar:Container(  
          decoration: BoxDecoration(color: ColorSys.Gray, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 5,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //duration: Duration(milliseconds: 800),
                  tabBackgroundColor: Colors.white,
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Dashboard',
                      iconColor: Colors.white,
                      // onPressed: () {
                      //  setState(() {
                      //    screens.elementAt(_selectedIndex);
                      //  });
                      // },
                    ),
                    GButton(
                      icon: LineIcons.plus_circle,
                      text: 'Add Project',
                      iconColor: Colors.white,
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Profile',
                      iconColor: Colors.white,
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
          ),
        ),
    );
  }
}
