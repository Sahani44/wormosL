// ignore_for_file: non_constant_identifier_names, no_logic_in_create_state, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
import '../../models/views/due_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/amountdata.dart';

class collection2 extends StatefulWidget {
  collection2(
    this.Location, {super.key}
  );
  String Location;
  static const id = '/collection2';
  @override
  State<collection2> createState() => _collection2State(Location);
}

class _collection2State extends State<collection2> {
  _collection2State(
    this.Location,
  );
  String Location;
  late String Member_Name;
  late String Phone;
  late String Plan;
  late String Account_No;
  late Timestamp date_open;
  late Timestamp date_mature;
  late Timestamp next_due_date;
  late int paid_installment;
  late int total_installment;
  late String status;
  late int Amount_Collected;
  late int Amount_Remaining;
  late int Monthly;
  late String place;
  String dropdownvalue ='Name';
  String dropdownvalue1 = 'Member_Name';
  var items = ['Name' ,'DOE'];
  late Map<String, Map<String,dynamic>> history;
  String accountType = '';
  String Type = '';
  var _isloading = true;
  late final _firestone = FirebaseFirestore.instance;
  int _currentIndex = 0;
  final _inactiveColor = const Color(0xffEBEBEB);
  var tiles =[];
  List<Widget> Memberlist = [];
  List<Widget> newMemberList =[];
  var totalClient = 0;
  var totalAmount = 0;
  var totalBalance = 0;
  late String add;
  late String phone;
  late String cif;
  
  void addData(List<Widget> Memberlist) {
    Memberlist.add(
      due_data(
        Location: Location,
        Member_Name: Member_Name,
        Plan: Plan,
        Account_No: Account_No,
        date_mature: date_mature,
        date_open: date_open, 
        next_due_date: next_due_date,
        Monthly: Monthly,
        Type: Type, 
        history: history, 
        Amount_Remaining: Amount_Remaining, 
        total_installment: total_installment, 
        paid_installment: paid_installment, 
        status: status, 
        Amount_Collected: Amount_Collected,
        accountType: accountType,
        cif: cif, 
        add: add, 
        phone: phone,
        callBack: callBack,
      ),
    );
  }

  Future<bool> getDocs (Memberlist) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestone.collection("new_account").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot1 = await _firestone.collection("new_account_d").get();
    tiles = querySnapshot.docs.toList() + querySnapshot1.docs.toList();
    for (var tile in tiles) {
      Member_Name = tile.get('Member_Name');
      Phone = tile.get("Phone_No");
      Plan = tile.get('Plan');
      Account_No = tile.get('Account_No');
      date_open = tile.get('Date_of_Opening');
      date_mature = tile.get('Date_of_Maturity');
      next_due_date = tile.get('next_due_date');
      phone = tile.get('Phone_No');
      cif = tile.get('CIF_No');
      add = tile.get('Address');
      status = tile.get('status');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      history = Map<String, Map<String,dynamic>>.from(tile.get('history'));
      Type = tile.get('Type');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      Monthly = tile.get('monthly');
      place = tile.get('place');
      if(widget.Location == '5 Days'){
        accountType = 'new_account';
      }
      else if(widget.Location == 'Monthly'){
        accountType = 'new_account';
      }
      else {
        accountType = 'new_account_d';
      }
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


  void getNewMemberList (int currentIndex) {
    for (int i=0; i<tiles.length; i++) {
      String plan = tiles[i].get('Plan');
      String type = tiles[i].get('Type');
      String loc = tiles[i].get('place');
      int ac = tiles[i].get('monthly');
      int ar = tiles[i].get('Amount_Remaining');
        if( _currentIndex == 0 && Location == type) {
          newMemberList.add(Memberlist[i]);
          totalClient += 1;
          totalAmount += ac;
          totalBalance += ar;
        }
        else if (_currentIndex == 1 && plan == "A" && Location == type) {
          newMemberList.add(Memberlist[i]) ;
          totalClient += 1;
          totalAmount += ac;
          totalBalance += ar;
        } 
        else if (_currentIndex == 2 && plan == "B" && Location == type) {
          newMemberList.add(Memberlist[i]);
          totalClient += 1;
          totalAmount += ac;
          totalBalance += ar;
        }
        else if( _currentIndex == 0 && Location == loc) {
          newMemberList.add(Memberlist[i]);
          totalClient += 1;
          totalAmount += ac;
          totalBalance += ar;
        }
        else if (_currentIndex == 1 && plan == "A" && Location == loc) {
          newMemberList.add(Memberlist[i]) ;
          totalClient += 1;
          totalAmount += ac;
          totalBalance += ar;
        } 
        else if (_currentIndex == 2 && plan == "B" && Location == loc) {
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
                    border: InputBorder.none
                  ),
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
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
              border: Border.all(
                width: 3,
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
              ),
            ),
            child: _buildAboveBar(),
          ),
          amountdata(totalClient, totalAmount,  totalBalance, context),
           _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              SizedBox(
                  height: size.height * 0.72,
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
