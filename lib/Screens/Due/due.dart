// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
import 'package:internship2/widgets/amountdata.dart';
import 'package:internship2/widgets/customnavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship2/Providers/getstatus.dart';

import '../../models/views/due_display.dart';

class due extends StatefulWidget {
  static const id = '/due';
  const due({super.key});
  @override
  State<due> createState() => _dueState();
}

class _dueState extends State<due> {

  late String Phone;
  late String Member_Name;
  late String Plan;
  late String Account_No;
  String accountType = '';
  late Timestamp date_open;
  late Timestamp date_mature;
  late String mode;
  late int paid_installment;
  late int total_installment;
  late String status;
  late String Type;
  late String place;
  late int Amount_Collected;
  late int Amount_Remaining;
  late int Monthly;
  var _isloading = true;
  late List<Map<String,dynamic>> history;
  late final _firestone = FirebaseFirestore.instance;
  int _currentIndex = 0;
  int _currentIndex2 = 0;
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


  void addData(List<Widget> Memberlist,) {
    Memberlist.add(
      due_data(
        Member_Name: Member_Name,
        Plan: Plan,
        Account_No: Account_No,
        date_mature: date_mature,
        date_open: date_open,
        paid_installment: paid_installment,
        status: status,
        Location: '',
        Amount_Collected: Amount_Collected,
        Amount_Remaining: Amount_Remaining,
        Monthly: Monthly, 
        total_installment: total_installment, 
        Type: Type,
        history: history, 
        accountType: '', 
        callBack: null,
      ),
    );
  }

  void condition(List<Widget> Memberlist, type, index) {
    if (type == 'A' && index == 1) {
      addData(Memberlist, );
    } else if (type == 'B' && index == 2){
      addData(Memberlist, );
    }
    else{
      addData(Memberlist, );
    }
  }

  void str(String Account) async {
    status = await getFieldValue(Account, 'status');
  }

  Future<bool> getDocs (Memberlist) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestone.collection("new_account").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot1 = await _firestone.collection("new_account_d").get();
    tiles = querySnapshot.docs.toList() + querySnapshot1.docs.toList();
    for (var tile in tiles) {
      Member_Name = tile.get('Member_Name');
      Phone = tile.get("Phone_No");
      Plan = tile.get('Plan');
      Account_No = tile.get('Account_No').toString();
      date_open = tile.get('Date_of_Opening');
      date_mature = tile.get('Date_of_Maturity');
      status = tile.get('status');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      history = List<Map<String,dynamic>>.from(tile.get('history'));
      Type = tile.get('Type');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      Monthly = tile.get('monthly');
      place = tile.get('place');
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

  void getNewMemberList (int currentIndex, int currentIndex2,List<Widget> newMemberList ) {
    String currentIndexPD = currentIndex == 0 ? 'Paid' : 'Due';
    String currentIndex2AB = currentIndex2 == 0 ? 'A' : 'B';
    for (int i=0; i<tiles.length; i++) {
      var status = tiles[i].get('status');
      var plan = tiles[i].get('Plan');
      if(status == currentIndexPD && plan == currentIndex2AB){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += Amount_Collected;
        totalBalance += Amount_Remaining;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    newMemberList.clear();
    totalClient = 0;
    totalAmount = 0;
    totalBalance = 0;
    getNewMemberList(_currentIndex, _currentIndex2,newMemberList);
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
              _buildAboveBar2(),
              _buildAboveBar(),
            ],
          ),
          amountdata(totalClient, totalAmount, totalBalance, context),
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
      containerWidth: size.width * 0.40,
      boxWidth: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex2,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex2= index),
      items: <AboveNavyBarItem>[
        // AboveNavyBarItem(
        //   alpha: 'All',
        //   activeColor: Colors.grey,
        //   inactiveColor: _inactiveColor,
        // ),
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

  Widget _buildAboveBar2() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedAboveBar(
      containerHeight: size.height * 0.07,
      containerWidth: size.width * 0.55,
      boxWidth: 100,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
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


// SingleChildScrollView(
//             child: StreamBuilder(
          //       stream: _firestone
          //           .collection('new_account')
          //           .orderBy('Member_Name')
          //           .snapshots(),
          //       builder: (context, snapshot) {
          //         if (!snapshot.hasData) {
          //           return const Center(
          //             child: CircularProgressIndicator(
          //               backgroundColor: Colors.lightBlueAccent,
          //             ),
          //           );
          //         }
          //         final tiles = snapshot.data!.docs;
          //         List<Widget> Memberlist = [];
          //         for (var tile in tiles) {
          //           Member_Name = tile.get('Member_Name');
          //           Plan = tile.get('Plan');
          //           Account_No = tile.get('Account_No').toString();
          //           date_open = tile.get('Date_of_Opening');
          //           date_mature = tile.get('Date_of_Maturity');
          //           mode = tile.get('mode');
          //           Type = tile.get('Type');
          //           status = tile.get('status');
          //           payment_dates = tile.get('payment_dates');
          //           paid_installment = tile.get('paid_installment');
          //           total_installment = tile.get('total_installment');
          //           Amount_Remaining = tile.get('Amount_Remaining');
          //           Amount_Collected = tile.get('Amount_Collected');
          //           Monthly = tile.get('monthly');
          //           str(Account_No);
          //           if (_currentIndex2 == 0) {
          //             if (status == 'Paid') {
          //               condition(Memberlist, Plan, _currentIndex);
          //             }
          //           } else if (_currentIndex2 == 1) {
          //             if (status != 'Paid') {
          //               condition(Memberlist, Plan, _currentIndex);
          //             }
          //           }
          //         }
          //         return _isloading
          //             ? const Center(
          //                 child: CircularProgressIndicator(),
          //               )
          //             : SingleChildScrollView(
          //                 child: SizedBox(
          //                   height: size.height * 0.61,
          //                   child: ListView.builder(
          //                     itemCount: Memberlist.length,
          //                     itemBuilder: (context, i) => Memberlist[i],
          //                   ),
          //                 ),
          //               );
          //       }),
          // )