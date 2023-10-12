import 'package:flutter/material.dart';
import 'package:internship2/Screens/Home/account_landing.dart';
import 'package:internship2/Screens/Collection/collection_landing.dart';
import 'package:internship2/Screens/Menu.dart';
import 'package:internship2/Screens/Place/new_member_landing.dart';
import 'package:internship2/Screens/deposit/deposit.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  final tabs = [
    const Center(
      child: NewMemberLanding(),
    ),
    const Center(
      child: menu(),
    ),
    const Center(
      child: HomeLanding(),
    ),
    const Center(
      child: CollectionLanding(),
    ),
    const Center(
      child: deposit(),
    ),
  ];
  var navigationBarIndex = 1;
  Color selectedColor = const Color(0xff32B9AE); // Define the selected tab color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[navigationBarIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          backgroundColor: Colors.white,
          onTap: (index) {
            changeIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 15.0),
          selectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 15.0),
          currentIndex: navigationBarIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                width: 70,
                height: 40,
                decoration: BoxDecoration(
                  color: navigationBarIndex == 0
                      ? selectedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  navigationBarIndex == 0
                      ? Icons.account_circle_rounded
                      : Icons.account_circle_outlined,
                  color: navigationBarIndex == 0 ? Colors.white : Colors.black,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 70,
                height: 40,
                decoration: BoxDecoration(
                  color: navigationBarIndex == 1
                      ? selectedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  navigationBarIndex == 1
                      ? Icons.search_rounded
                      : Icons.search_outlined,
                  color: navigationBarIndex == 1 ? Colors.white : Colors.black,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 70,
                height: 40,
                decoration: BoxDecoration(
                  color: navigationBarIndex == 2
                      ? selectedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  navigationBarIndex == 2
                      ? Icons.home_filled
                      : Icons.home_outlined,
                  color: navigationBarIndex == 2 ? Colors.white : Colors.black,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 70,
                height: 40,
                decoration: BoxDecoration(
                  color: navigationBarIndex == 3
                      ? selectedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  navigationBarIndex == 3
                      ? Icons.event_note_sharp
                      : Icons.event_note_outlined,
                  color: navigationBarIndex == 3 ? Colors.white : Colors.black,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 70,
                height: 40,
                decoration: BoxDecoration(
                  color: navigationBarIndex == 4
                      ? selectedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  navigationBarIndex == 4
                      ? Icons.account_balance
                      : Icons.account_balance_outlined,
                  color: navigationBarIndex == 4 ? Colors.white : Colors.black,
                ),
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      navigationBarIndex = index;
    });
  }
}
