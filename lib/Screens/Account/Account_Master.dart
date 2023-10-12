// ignore_for_file: non_constant_identifier_names, camel_case_types, no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
import '../../models/views/displayed_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/amountdata.dart';

class acc_master extends StatefulWidget {
  static const id = '/acc_master';
  acc_master(this.Location, {super.key});
  String Location;
  @override
  State<acc_master> createState() => _acc_masterState(Location);
}

class _acc_masterState extends State<acc_master> {
  _acc_masterState(
    this.Location,
  );
  String Location;
  int _currentIndex = 0;
  int _currentIndex1 = 0;
  late String Member_Name;
  late String Plan;
  late String Account_No;
  late Timestamp date_open;
  late Timestamp date_mature;
  late int monthly;
  bool _isloading = true;
  late String type;
  late int total_installment;
  late int Amount_Remaining;
  late int Amount_Collected;
  late Map<String, Map<String,dynamic>> history;
  late int paid_installment;
  late final _firestone = FirebaseFirestore.instance;
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
  late String add;
  late String phone;
  late String cif;
  late String place;
  
  void addData(List<Widget> Memberlist) {
    Memberlist.add(
      displayeddata(
        callback: callBack,
        accountType: place == '' ? 'new_account' : 'new_account_d',
        deleted: false,
        Location: Location,
        Member_Name: Member_Name,
        Plan: Plan,
        Account_No: Account_No,
        date_mature: date_mature,
        date_open: date_open, 
        monthly: monthly,
        type: type, 
        history: history, 
        Amount_Remaining: Amount_Remaining, 
        total_installment: total_installment, 
        paid_installment: paid_installment, 
        cif: cif, 
        Amount_Collected: Amount_Collected, 
        add: add, 
        phone: phone,
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
      phone = tile.get('Phone_No');
      cif = tile.get('CIF_No');
      add = tile.get('Address');
      place = tile.get('place');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      history = Map<String, Map<String,dynamic>>.from(tile.get('history'));
      type = tile.get('Type');
      monthly = tile.get('monthly');
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

  void getNewMemberList (int currentIndex, int currentIndex1) {
    for (int i=0; i<tiles.length; i++) {
      var type = tiles[i].get('Type');
      var plan = tiles[i].get('Plan');
      int ac = tiles[i].get('monthly');
      int ar = tiles[i].get('Amount_Remaining');
      if(_currentIndex == 0 && _currentIndex1 == 0 && plan == 'A'){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += ac;
        totalBalance += ar;
      }
      else if (_currentIndex == 2 && type == '5 Days' && _currentIndex1 == 0 && plan == 'A') {
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += ac;
        totalBalance += ar;
      } 
      else if (_currentIndex == 3 && type == 'Monthly' && _currentIndex1 == 0 && plan == 'A') {
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += ac;
        totalBalance += ar;
      }
      else if( _currentIndex == 1 && type == 'Daily' && _currentIndex1 == 0 && plan == 'A') {
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += ac;
        totalBalance += ar;
      }
      else if(_currentIndex == 0 && _currentIndex1 == 1 && plan == 'B'){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += ac;
        totalBalance += ar;
      }
      else if (_currentIndex == 2 && type == '5 Days' && _currentIndex1 == 1 && plan == 'B') {
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += ac;
        totalBalance += ar;
      } 
      else if (_currentIndex == 3 && type == 'Monthly' && _currentIndex1 == 1 && plan == 'B') {
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += ac;
        totalBalance += ar;
      }
      else if( _currentIndex == 1 && type == 'Daily' && _currentIndex1 == 1 && plan == 'B') {
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += ac;
        totalBalance += ar;
      }
    }
  }

  callBack() {
      Memberlist = [];
      getDocs(Memberlist).then((value) => setState(() {
      _isloading = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    newMemberList = [];
    totalClient = 0;
    totalAmount = 0;
    totalBalance = 0;
    getNewMemberList(_currentIndex, _currentIndex1);
    // tiles.sort((a, b) {
    //   if(dropdownvalue1 == 'Member_Name') {
    //    return a.get('Member_Name').compareTo(b.get('Member_Name'));
    //   }
    //   else {
    //    return a.get('Date_of_Opening').compareTo(b.get('Date_of_Opening'));
    //   }
    // },);
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
          Row(
            children: [
              _buildAboveBar(),
              _buildAboveBar1(),
            ],
          ),
          amountdata(totalClient, totalAmount,  totalBalance, context),
          _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              SizedBox(
                  height: size.height * 0.73,
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
      containerWidth : size.width * 0.70,
      boxWidth: 60,
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
          alpha: 'Daily',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: '5 Days',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: 'Monthly',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
      ],
    );
  }

  Widget _buildAboveBar1() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedAboveBar(
      containerHeight: size.height * 0.07,
      containerWidth : size.width * 0.26,
      boxWidth: 40,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex1,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex1 = index),
      items: <AboveNavyBarItem>[
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
  }

}
