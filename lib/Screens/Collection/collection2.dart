// ignore_for_file: non_constant_identifier_names, no_logic_in_create_state, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
import 'package:internship2/Providers/_buildBottomBar.dart';
import 'package:internship2/Screens/Collection/collection.dart';
import 'package:internship2/Screens/Collection/collection_landing.dart';
import '../../models/views/due_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  late String mode;
  late int paid_installment;
  late int total_installment;
  late String status;
  late int Amount_Collected;
  late int Amount_Remaining;
  late int Monthly;
  late int totalCollection;
  late int totalAmountCollected;
  late Timestamp payment_date;
  String accountType = '';
  String Type = '';
  var _isloading = false;
  late final _firestone = FirebaseFirestore.instance;
  int _currentIndex = 0;
  // int _currentIndex2 = 0;
  final _inactiveColor = const Color(0xffEBEBEB);
  // void addData(List<Widget> Memberlist, size) {
  //   print(Member_Name);
    
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> Memberlist = [];
    if(widget.Location == '5 Days'){
      Type = '5 Days';
      accountType = 'new_account';
    }
    else if(widget.Location == 'Monthly'){
      Type = 'Monthly';
      accountType = 'new_account';
    }
    else {
      Type = 'Daily';
      accountType = 'new_account_d';
    }

    if(_currentIndex == 1){
      Plan = 'A';
    }
    else if(_currentIndex == 2){
      Plan = 'B';
    }
    else {
      Plan = '';
    }
    totalAmountCollected = 0;
    totalCollection = 0;
    Size size = MediaQuery.of(context).size;
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
                iconSize: 45,
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
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
              ),
            ),
            child: _buildAboveBar(),
          ),
          StreamBuilder(
            stream: 
            (widget.Location == '5 Days' || widget.Location == 'Monthly') 
            ? (Plan == '')
                ? _firestone
                  .collection('new_account')
                  .where('Type',isEqualTo: widget.Location)
                  .orderBy('Member_Name')
                  .snapshots()
                :_firestone
                  .collection('new_account')
                  .where('Type',isEqualTo: widget.Location)
                  .where('Plan', isEqualTo: Plan)
                  .orderBy('Member_Name')
                  .snapshots()
            : (Plan == '')
                ?_firestone
                  .collection('new_account_d')
                  .where('place',isEqualTo: widget.Location)
                  .orderBy('Member_Name')
                  .snapshots()
                : _firestone
                  .collection('new_account_d')
                  .where('place',isEqualTo: widget.Location)
                  .where('Plan', isEqualTo: Plan)
                  .orderBy('Member_Name')
                  .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              Iterable tiles = {};
              tiles = snapshot.data!.docs;
              for (var tile in tiles) {
                Member_Name = tile.get('Member_Name');
                Phone = tile.get("Phone_No");
                Plan = tile.get('Plan');
                Account_No = tile.get('Account_No').toString();
                date_open = tile.get('Date_of_Opening');
                date_mature = tile.get('Date_of_Maturity');
                mode = tile.get('mode');
                status = tile.get('status');
                paid_installment = tile.get('paid_installment');
                total_installment = tile.get('total_installment');
                payment_date = tile.get('payment_date');
                Type = tile.get('Type');
                Amount_Remaining = tile.get('Amount_Remaining');
                Amount_Collected = tile.get('Amount_Collected');
                Monthly = tile.get('monthly');
                totalCollection += Monthly;
                totalAmountCollected += Amount_Remaining;
                Memberlist.add(
                due_data(
                  size: size,
                  Member_Name: Member_Name,
                  Plan: Plan,
                  Account_No: Account_No,
                  date_mature: date_mature,
                  date_open: date_open,
                  mode: mode,
                  paid_installment: paid_installment,
                  total_installment: total_installment,
                  status: status,
                  Location: Location,
                  Amount_Collected: Amount_Collected,
                  Amount_Remaining: Amount_Remaining,
                  Monthly: Monthly,
                  Type: Type,
                  payment_date: payment_date,
                  accountType: accountType,
                ),
              );
              }
              return _isloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                    children: [
                      amountdata(totalCollection , totalAmountCollected),
                      SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                  height: size.height * 0.7,
                                  child: ListView.builder(
                                    itemCount: Memberlist.length,
                                    itemBuilder: (context, i) => Memberlist[i],
                                  )),
                            ],
                        ),
                ),
                    ],
                  );
              }
            )
            ,
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

  Widget amountdata(int totalCollection1, int totalAmountCollected1) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        height: size.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
          border: Border.all(
            width: 3,
            color: Colors.grey.shade300,
            // style: BorderStyle.solid,
          ),
          color: Colors.grey[300],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                  ),
                  color : Colors.white,
                ),
                child: const Text('40')
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                  ),
                  color : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Total Collection' , style: TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600),),
                    Text('$totalCollection1')
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                    border: Border.all(
                      width: 8,
                      color: Colors.white
                    ),
                    color : Colors.white,
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Amount Collected' , style: TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600)),
                    Text('$totalAmountCollected1')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//   Widget _buildAboveBar2() {
//     Size size = MediaQuery.of(context).size;
//     return CustomAnimatedAboveBar(
//       containerHeight: size.height * 0.07,
//       backgroundColor: Colors.white,
//       selectedIndex: _currentIndex2,
//       showElevation: true,
//       itemCornerRadius: 24,
//       curve: Curves.easeIn,
//       onItemSelected: (index) => setState(() => _currentIndex2 = index),
//       items: <AboveNavyBarItem>[
//         AboveNavyBarItem(
//           alpha: 'Daily',
//           activeColor: Colors.grey,
//           inactiveColor: _inactiveColor,
//         ),
//         AboveNavyBarItem(
//           alpha: 'Weekly',
//           activeColor: Colors.grey,
//           inactiveColor: _inactiveColor,
//         ),
//         AboveNavyBarItem(
//           alpha: 'Monthly',
//           activeColor: Colors.grey,
//           inactiveColor: _inactiveColor,
//         ),
//         // AboveNavyBarItem(
//         //   alpha: 'Quarterly',
//         //   activeColor: Colors.grey,
//         //   inactiveColor: _inactiveColor,
//         // ),
//       ],
//     );
//   }
}
