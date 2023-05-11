import 'package:flutter/material.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../../helper/CustomView/CustomView.dart';
import 'doctor_booking_page/DoctorBookingScreen.dart';
import 'doctor_chat_page/DoctorChatListPage.dart';
import 'doctor_home_page/DoctorHomeScreen.dart';
import 'doctor_more_page/DoctorMorePage.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({Key? key}) : super(key: key);

  @override
  State<DoctorMainScreen> createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  TextEditingController optctr = TextEditingController();
  CustomView custom = CustomView();
  int _selectedIndex = 0;
  static const List<Widget> Screens = [
    DoctorHomeScreen(),
    DoctorBookingScreen(),
    DoctorChatListScreen(),
    DoctorMorePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/dhomeIcon.png"),
                      size: 20.0),
                  label: 'Home',
                  tooltip: 'Home'),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/dIcon.png"),
                    size: 20.0),
                label: 'Booking',
                tooltip: 'Booking',
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/ChatIcon.png"),
                      size: 20.0),
                  label: 'Chat',
                  tooltip: 'Chat'),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/moreIcon.png"),
                      size: 20),
                  label: 'More',
                  tooltip: 'More'),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: MyColor.iconColor,
            unselectedItemColor: MyColor.black,
            selectedFontSize: 12,
            selectedLabelStyle: const TextStyle(fontSize: 12),
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(color: Colors.black38),
            iconSize: 25,
            onTap: _onItemTapped,
            elevation: 5),
        body: Screens.elementAt(_selectedIndex),
      ),
    );
  }
}
