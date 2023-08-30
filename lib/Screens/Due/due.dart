// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
import 'package:internship2/Providers/custom_animated_bottom_bar.dart';
import 'package:internship2/Providers/_buildBottomBar.dart';
import 'package:internship2/widgets/customnavbar.dart';
import '../../models/views/due_display.dart';
import 'package:internship2/Screens/Menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship2/Providers/getstatus.dart';

class due extends StatefulWidget {
  static const id = '/due';
  due(
    this.Location,
  );
  String Location;
  @override
  State<due> createState() => _dueState(Location);
}

class _dueState extends State<due> {
  _dueState(
    this.Location,
  );
  String Location;
  late String Member_Name;
  late String Plan;
  late String Account_No;
  late Timestamp date_open;
  late Timestamp date_mature;
  late String mode;
  late int paid_installment;
  late int total_installment;
  late String status;
  late String Type;
  late int Amount_Collected;
  late int Amount_Remaining;
  late int Monthly;
  var _isloading = false;
  late Timestamp payment_date;
  late final _firestone = FirebaseFirestore.instance;
  int _currentIndex = 1;
  int _currentIndex2 = 0;
  final _inactiveColor = const Color(0xffEBEBEB);
  void addData(List<Widget> Memberlist, size) {
    // Memberlist.add(
    //   due_data(
    //     size: size,
    //     Member_Name: Member_Name,
    //     Plan: Plan,
    //     Account_No: Account_No,
    //     date_mature: date_mature,
    //     date_open: date_open,
    //     mode: mode,
    //     paid_installment: paid_installment,
    //     status: status,
    //     Location: Location,
    //     Amount_Collected: Amount_Collected,
    //     Amount_Remaining: Amount_Remaining,
    //     Monthly: Monthly, 
    //     total_installment: total_installment, 
    //     Type: Type,
    //     payment_date: payment_date,
    //   ),
    // );
  }

  void condition(List<Widget> Memberlist, size, type, index) {
    if (type == 'A' && index == 1) {
      addData(Memberlist, size);
    } else if (type == 'B' && index == 2){
      addData(Memberlist, size);
    }
    else{
      addData(Memberlist, size);
    }
  }

  void str(String Account) async {
    status = await getFieldValue(Account, 'status');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomNavBar()),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff144743),
          ),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              width: size.width * 0.60,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                  color: const Color(0XFFEBEBEB),
                  borderRadius: BorderRadius.circular(18)),
              child: const TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0XFF999999),
                    ),
                    hintText: 'Search',
                    border: InputBorder.none),
              ),
            ),
            IconButton(
                iconSize: 50,
                onPressed: () {},
                icon: Image.asset('assets/Acc/trailing.png'))
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
              border: Border.all(
                width: 3,
                color: Colors.white,
                style: BorderStyle.solid,
              ),
            ),
            child: _buildAboveBar2(),
          ),
          /* Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              border: Border.all(
                width: 3,
                color: Colors.grey,
                style: BorderStyle.solid,
              ),
            ),
            child: _buildAboveBar(),
          ), */
          SingleChildScrollView(
            child: StreamBuilder(
                stream: _firestone
                    .collection('new_account')
                    .doc(Location)
                    .collection(Location)
                    .orderBy('Member_Name')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final tiles = snapshot.data!.docs;
                  List<Widget> Memberlist = [];
                  for (var tile in tiles) {
                    Member_Name = tile.get('Member_Name');
                    Plan = tile.get('Plan');
                    Account_No = tile.get('Account_No').toString();
                    date_open = tile.get('Date_of_Opening');
                    date_mature = tile.get('Date_of_Maturity');
                    mode = tile.get('mode');
                    Type = tile.get('Type');
                    status = tile.get('status');
                    payment_date = tile.get('payment_date');
                    paid_installment = tile.get('paid_installment');
                    total_installment = tile.get('total_installment');
                    Amount_Remaining = tile.get('Amount_Remaining');
                    Amount_Collected = tile.get('Amount_Collected');
                    Monthly = tile.get('monthly');
                    str(Account_No);
                    if (_currentIndex2 == 0) {
                      if (status == 'Paid') {
                        condition(Memberlist, size, Plan, _currentIndex);
                      }
                    } else if (_currentIndex2 == 1) {
                      if (status != 'Paid') {
                        condition(Memberlist, size, Plan, _currentIndex);
                      }
                    }
                  }
                  return _isloading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: SizedBox(
                            height: size.height * 0.61,
                            child: ListView.builder(
                              itemCount: Memberlist.length,
                              itemBuilder: (context, i) => Memberlist[i],
                            ),
                          ),
                        );
                }),
          ),
        ],
      ),
    );
  }

/*   Widget _buildAboveBar() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedAboveBar(
      containerHeight: size.height * 0.07,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <AboveNavyBarItem>[
        AboveNavyBarItem(
          alpha: 'All',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: 'A',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: 'B',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
      ],
    );
  } */

  Widget _buildAboveBar2() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedAboveBar(
      containerHeight: size.height * 0.07,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex2,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex2 = index),
      items: <AboveNavyBarItem>[
        AboveNavyBarItem(
          alpha: 'Paid',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: 'Due',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
      ],
    );
  }
}
