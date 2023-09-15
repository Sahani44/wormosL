// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
import 'package:internship2/widgets/amountdata.dart';
import 'package:internship2/widgets/customnavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship2/Providers/getstatus.dart';

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
  late List<Map<String,dynamic>> history;
  late int paid_installment;
  late int total_installment;
  late bool deposit_field;
  late int Amount_Collected;
  late int Amount_Remaining;
  late int Monthly;
  var _isloading = false;
  late final _firestone = FirebaseFirestore.instance;
  String dropdownvalue ='Name';
  String dropdownvalue1 = 'Member_Name';
  var items = ['Name' ,'DOE'];
  var tiles =[];
  List<Widget> Memberlist = [];
  List<Widget> newMemberList =[];
  var totalClient = 0;
  var totalAmount = 0;
  var totalBalance = 0;
  int _currentIndex2 = 0;
  final _inactiveColor = const Color(0xffEBEBEB);

  
  void addData(List<Widget> Memberlist,) {
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
        history: history
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
      deposit_field = tile.get('deposit_field');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      history = List<Map<String,dynamic>>.from(tile.get('history'));
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

    void getNewMemberList (int currentIndex2 ) {
    for (int i=0; i<tiles.length; i++) {
      var deposit_field = tiles[i].get('deposit_field');
      bool currentIndexPD = currentIndex2 == 0 ? false : true;
      if(deposit_field == currentIndexPD){
        newMemberList.add(Memberlist[i]);
        totalClient += 1;
        totalAmount += Amount_Collected;
        totalBalance += Amount_Remaining;
      }
    }
  }


  // void str(String Account) async {
  //   status = await getFieldValue(Account, 'status');
  // }

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    newMemberList = [];
    totalClient = 0;
    totalAmount = 0;
    totalBalance = 0;
    getNewMemberList(_currentIndex2);
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
          amountdata(totalClient, totalAmount, totalBalance, context),
          _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              SizedBox(
                  height: size.height * 0.63,
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