// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
import 'package:internship2/Providers/custom_animated_bottom_bar.dart';
import 'package:internship2/Providers/_buildBottomBar.dart';
import 'package:internship2/models/views/displayed_data.dart';
import 'package:internship2/widgets/customnavbar.dart';
import '../../models/views/maturity_display.dart';
import 'package:internship2/Screens/Menu.dart';
import '../../models/views/due_display.dart';
import '../../widgets/amountdata.dart';

class maturity extends StatefulWidget {
  static const id = '/maturity';
  const maturity({super.key}
  );
  @override
  State<maturity> createState() => _maturityState();
}

class _maturityState extends State<maturity> {

  late String Member_Name;
  late String Plan;
  late String Account_No;
  late Timestamp date_open;
  late Timestamp date_mature;
  late List<Timestamp> payment_dates;
  late String mode;
  late int paid_installment;
  late int total_installment;
  late String status;
  late int Amount_Collected;
  late int Amount_Remaining;
  late int Monthly;
  String Location = '';
  String Type = 'Daily';
  int value = 0;
  var _isloading = false;
  late final _firestone = FirebaseFirestore.instance;
  int _currentIndex = 0;
  final _inactiveColor = const Color(0xffEBEBEB);
  String dropdownvalue ='Name';
  String dropdownvalue1 = 'Member_Name';
  var items = ['Name' ,'DOE'];
  var tiles =[];
  List<Widget> Memberlist = [];
  List<Widget> newMemberList =[];
  var totalClient = 0;
  var totalAmount = 0;
  var totalBalance = 0;

  void addData(List<Widget> Memberlist) {
    Memberlist.add(
      displayeddata(
        Location: Location,
        Member_Name: Member_Name,
        Plan: Plan,
        Account_No: Account_No,
        date_mature: date_mature,
        date_open: date_open, 
        monthly: Monthly,
        type: Type, 
        payment_dates: payment_dates, 
        Amount_Remaining: Amount_Remaining, 
        total_installment: total_installment, 
        paid_installment: paid_installment,
      ),
    );
  }

  Future<bool> getDocs (Memberlist) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestone.collection("new_account").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot1 = await _firestone.collection("new_account_d").get();
    tiles = querySnapshot.docs.toList() + querySnapshot1.docs.toList();
    for (var tile in tiles) {
      Member_Name = tile.get('Member_Name');
      Plan = tile.get('Plan');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      payment_dates = List<Timestamp>.from(tile.get('payment_dates'));
      Type = tile.get('Type');
      Monthly = tile.get('monthly');
      Account_No = tile.get('Account_No').toString();
      date_open = tile.get('Date_of_Opening');
      date_mature = tile.get('Date_of_Maturity');
      addData(Memberlist);
    }
    return false;
  
  }

  @override
  void initState() {
    super.initState();
    getDocs(Memberlist).then((value) => setState(() {
      _isloading = value;
    }));
  }

  void getNewMemberList (int currentIndex,) {
    for (int i=0; i<tiles.length; i++) {
      var paid_installment = tiles[i].get('paid_installment');
      if(_currentIndex ==0 && paid_installment >= 54){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += Amount_Collected;
        totalBalance += Amount_Remaining;
      }
      else if(_currentIndex == 2 && paid_installment == 58){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += Amount_Collected;
        totalBalance += Amount_Remaining;
      }
      else if(_currentIndex == 3 && paid_installment == 57){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += Amount_Collected;
        totalBalance += Amount_Remaining;
      }
      else if(_currentIndex == 4 && paid_installment == 56){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += Amount_Collected;
        totalBalance += Amount_Remaining;
      }
      else if(_currentIndex == 5 && paid_installment == 55){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += Amount_Collected;
        totalBalance += Amount_Remaining;
      }
      else if(_currentIndex == 6 && paid_installment == 54){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += Amount_Collected;
        totalBalance += Amount_Remaining;
      }
      else if(_currentIndex == 1 && paid_installment == 59){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += Amount_Collected;
        totalBalance += Amount_Remaining;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int month = now.month;
    int year = now.year;
    Size size = MediaQuery.of(context).size;
    newMemberList = [];
    totalClient = 0;
    totalAmount = 0;
    totalBalance = 0;
    getNewMemberList(_currentIndex);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
              width: size.width * 0.55,
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: DropdownButton(
                value: dropdownvalue,
                icon: Image.asset('assets/Acc/trailing.png'),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    if(newValue == 'Name'){
                      dropdownvalue1 = 'Member_Name';
                    }
                    else{
                      dropdownvalue1 = 'Date_of_Opening';
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
                border: Border.all(
                  width: 3,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),
              child: _buildAboveBar(),
            ),
          ),
          amountdata(totalClient, totalAmount,  totalBalance, context),
          _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              SizedBox(
                  height: size.height * 0.68,
                  child: ListView.builder(
                    itemCount: newMemberList.length,
                    itemBuilder: (context, i) {
                      return newMemberList[i];
                    },
                  )
                ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAboveBar() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedAboveBar(
      containerHeight: size.height * 0.07,
      boxWidth: 45,
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
          alpha: '1',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: '2',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: '3',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: '4',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: '5',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: '6',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
      ],
    );
  }

  
}
