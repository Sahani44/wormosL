// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
import 'package:internship2/widgets/amountdata.dart';
import 'package:internship2/widgets/customnavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/views/deposit_display.dart';

class deposit extends StatefulWidget {
  static const id = '/deposit';
  const deposit({super.key}
  );
  @override
  State<deposit> createState() => _depositState();
}

class _depositState extends State<deposit> {
  
  late String Member_Name;
  late String Plan;
  late String Account_No;
  late Timestamp date_open;
  late Timestamp date_mature;
  late SplayTreeMap<String, Map<String,dynamic>> history;
  late int paid_installment;
  late int total_installment;
  late bool deposit_field;
  late int Amount_Collected;
  late int Amount_Remaining;
  late int Monthly;
  late String accountType;
  late String id;
  var _isloading = true;
  late final _firestone = FirebaseFirestore.instance;
  String dropdownvalue ='Name';
  String dropdownvalue1 = 'Member_Name';
  var items = ['Name' ,'DOE'];
  var tiles =[];
  var newTiles = [];
  List<Widget> Memberlist = [];
  List<Widget> newMemberList =[];
  List results = [];
  var totalClient = 0;
  var totalAmount = 0;
  var totalBalance = 0;
  int _currentIndex2 = 0;
  int _currentIndex = 0;
  final _inactiveColor = const Color(0xffEBEBEB);
  final myController = TextEditingController();

  
  void addData() {
    Memberlist.add(
      deposit_data(
        deposit_field: deposit_field,
        Member_Name: Member_Name,
        Plan: Plan,
        Account_No: Account_No,
        date_mature: date_mature,
        date_open: date_open,
        paid_installment: paid_installment,
        total_installment: total_installment,
        Location: '',
        Amount_Collected: Amount_Collected,
        Amount_Remaining: Amount_Remaining,
        Monthly: Monthly,
        history: history,
        callBack: callBack,
        accountType: accountType,
        id: id
      ),
    );
  }

    Future<bool> getDocs () async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestone.collection("new_account").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot1 = await _firestone.collection("new_account_d").get();
    tiles = querySnapshot.docs.toList() + querySnapshot1.docs.toList();
    tiles.sort((a, b) {
      if(dropdownvalue1 == 'Member_Name') {
       return a.get('Member_Name').compareTo(b.get('Member_Name'));
      }
      else {
       return a.get('Date_of_Opening').compareTo(b.get('Date_of_Opening'));
      }
    },);
    createTiles(tiles);
    return false;
  
  }

  void createTiles(List nT) {
    Memberlist = [];
    newTiles = [];
    for (var tile in nT) {
      newTiles.add(tile);
      id = tile.id;
      Member_Name = tile.get('Member_Name');
      Plan = tile.get('Plan');
      deposit_field = tile.get('deposit_field');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      history = SplayTreeMap<String, Map<String,dynamic>>.from(tile.get('history'));
      Monthly = tile.get('monthly');
      Account_No = tile.get('Account_No').toString();
      date_open = tile.get('Date_of_Opening');
      date_mature = tile.get('Date_of_Maturity');
      accountType = tile.get('Type') == 'Daily' ? 'new_account_d' : 'new_account';
      addData();
    }
  }

  @override
  void initState() {
    super.initState();
    getDocs().then((value) => setState(() {
      _isloading = value;
    }));
  }

  void getNewMemberList (int currentIndex2 ,int currentIndex) {
    for (int i=0; i<newTiles.length; i++) {
      // var deposit_field = newTiles[i].get('deposit_field');
      int ac = newTiles[i].get('monthly');
      int ar = newTiles[i].get('Amount_Remaining');
      bool df = newTiles[i].get('deposit_field');
      String plan = newTiles[i].get('Plan');
      // bool currentIndexPD = currentIndex2 == 0 ? false : true;
      String currentIndexAB = currentIndex == 1 ? 'A' : currentIndex == 2 ? 'B' : '';
      if(ac <= ar){
          if(currentIndex2 == 0 && currentIndexAB == ''){
          newMemberList.add(Memberlist[i]);
          totalClient += 1;
          totalAmount += ac;
          totalBalance += ar;
        } else {
          if(currentIndex2 == 0 && currentIndexAB == plan){
            newMemberList.add(Memberlist[i]);
            totalClient += 1;
            totalAmount += ac;
            totalBalance += ar;
          }
        }
      } 
      if(df) {
        if(currentIndex2 == 1 && currentIndexAB == ''){
          newMemberList.add(Memberlist[i]);
          totalClient += 1;
          totalAmount += ac;
          totalBalance += ar;
        } else {
          if(currentIndex2 == 1 && currentIndexAB == plan){
            newMemberList.add(Memberlist[i]);
            totalClient += 1;
            totalAmount += ac;
            totalBalance += ar;
          }
        }
      }
    }
  }

  callBack() {
    // setState(() {
    //   _isloading = true;
    // });
    Memberlist = [];
    getDocs().then((value) => setState(() {
      _isloading = value;
    }));
  }

  // void str(String Account) async {
  //   status = await getFieldValue(Account, 'status');
  // }
  void _runFilter(String enteredKeyword) {
    results = [];
    if(enteredKeyword.isEmpty){
      results = tiles;
    } else {
      results = tiles
                .where((element) => element.get('Member_Name').toLowerCase().contains(enteredKeyword.toLowerCase()))
                .toList();
    }
    results.sort((a, b) {
      if(dropdownvalue1 == 'Member_Name') {
       return a.get('Member_Name').compareTo(b.get('Member_Name'));
      }
      else {
       return a.get('Date_of_Opening').compareTo(b.get('Date_of_Opening'));
      }
    },);
    createTiles(results);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    newMemberList = [];
    totalClient = 0;
    totalAmount = 0;
    totalBalance = 0;
    getNewMemberList(_currentIndex2, _currentIndex);
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
              width: size.width * 0.55,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                  color: const Color(0XFFEBEBEB),
                  borderRadius: BorderRadius.circular(18)),
              child: TextField(
                controller: myController,
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
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
                    _runFilter(myController.text);
                  });
                },
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            _buildAboveBar(),
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
            amountdata(totalClient, totalAmount, totalBalance, context),
            _isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
              children: [
                SizedBox(
                    height: size.height * 0.55,
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
      ),
    );
  }

  Widget _buildAboveBar2() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedAboveBar(
      containerHeight: size.height * 0.07,
      boxWidth: 160,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex2,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        setState(() => _currentIndex2 = index);
      },
      items: <AboveNavyBarItem>[
        AboveNavyBarItem(
          alpha: 'Paid Members',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: 'Deposited',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
      ],
    );
  }

  Widget _buildAboveBar() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedAboveBar(
      containerHeight: size.height * 0.07,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      boxWidth: 100,
      onItemSelected: (index) => setState(() {_currentIndex = index;}),
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
  }
}


/*

SingleChildScrollView(
            child: StreamBuilder(
                stream: _firestone
                    .collection('new_account')
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
                    status = tile.get('status');
                    payment_dates = tile.get('payment_dates');
                    paid_installment = tile.get('paid_installment');
                    total_installment = tile.get('total_installment');
                    Amount_Remaining = tile.get('Amount_Remaining');
                    Amount_Collected = tile.get('Amount_Collected');
                    deposit_field = tile.get("deposit_field");
                    Monthly = tile.get('monthly');
                    str(Account_No);
                    if (_currentIndex2 == 0) {
                      if (deposit_field == true) addData(Memberlist, size);
                    } else if (_currentIndex2 == 1) {
                      if (deposit_field == false) addData(Memberlist, size);
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

*/


/*
  void getNewMemberList (int currentIndex2 ,int currentIndex) {
    for (int i=0; i<newTiles.length; i++) {
      var deposit_field = newTiles[i].get('deposit_field');
      int ac = newTiles[i].get('monthly');
      int ta = newTiles[i].get('Amount_Collected');
      int ar = newTiles[i].get('Amount_Remaining');
      String plan = newTiles[i].get('Plan');
      bool currentIndexPD = currentIndex2 == 0 ? false : true;
      String currentIndexAB = currentIndex == 1 ? 'A' : currentIndex == 2 ? 'B' : '';
      if(ac == ar){
          if(deposit_field == currentIndexPD && currentIndexAB == ''){
          newMemberList.add(Memberlist[i]);
          totalClient += 1;
          totalAmount += ac;
          totalBalance += ar;
        }
        else {
          if(deposit_field == currentIndexPD && currentIndexAB == plan){
            newMemberList.add(Memberlist[i]);
            totalClient += 1;
            totalAmount += ac;
            totalBalance += ar;
          }
      }
      }
    }
  }
*/