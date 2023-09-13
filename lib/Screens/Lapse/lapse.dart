// ignore_for_file: non_constant_identifier_names, prefer_final_fields, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
import 'package:internship2/widgets/customnavbar.dart';

class lapse extends StatefulWidget {
  static const id = '/lapse';
  const lapse({super.key});
  @override
  State<lapse> createState() => _lapseState();
}

class _lapseState extends State<lapse> {
  
  late String Member_Name;
  late String Plan;
  late String Account_No;
  late Timestamp date_open;
  late Timestamp date_mature;
  late Timestamp payment_date;
  late String mode;
  late int paid_installment;
  late int total_installment;
  late String status;
  late int Amount_Collected;
  late int Amount_Remaining;
  late int Monthly;
  String Type = 'Daily';
  int value = 0;
  var _isloading = false;
  late final _firestone = FirebaseFirestore.instance;
  int _currentIndex = 0;
  int _currentIndex1 = 0;
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


  void addData(List<Widget> Memberlist, size) {
    // Memberlist.add(
      // due_data(
      //   size: size,
      //   Member_Name: Member_Name,
      //   Plan: Plan,
      //   Account_No: Account_No,
      //   date_mature: date_mature,
      //   date_open: date_open,
      //   mode: mode,
      //   paid_installment: paid_installment,
      //   total_installment: total_installment,
      //   status: status,
      //   Location: Location,
      //   Amount_Collected: Amount_Collected,
      //   Amount_Remaining: Amount_Remaining,
      //   Monthly: Monthly,
      //   Type: Type,
      //   payment_date: payment_date,
      // ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int month = now.month;
    int year = now.year;
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                localAmountdata(totalClient, totalAmount),
                _buildAboveBar1()
              ],
            ),
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

  Widget _buildAboveBar1() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedAboveBar(
      containerHeight: size.height * 0.07,
      containerWidth: size.width * 0.40,
      boxWidth: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex1,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex1 = index),
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

  Widget localAmountdata(int totalClient, int totalAmount) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.54,
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
                child: Text('$totalClient')
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                width: 125,
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
                    const Text('Amount' , style: TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600),),
                    Text('$totalAmount')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}


/*
            StreamBuilder(
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
                  Type = tile.get('Type');
                  mode = tile.get('mode');
                  payment_date = tile.get('payment_date');
                  status = tile.get('status');
                  paid_installment = tile.get('paid_installment');
                  total_installment = tile.get('total_installment');
                  Amount_Remaining = tile.get('Amount_Remaining');
                  Amount_Collected = tile.get('Amount_Collected');
                  Monthly = tile.get('monthly');
                  final datem = DateTime.fromMillisecondsSinceEpoch(
                      date_mature.millisecondsSinceEpoch);
                  int yearm = datem.year;
                  int monthm = datem.month;
                  if ((month - monthm == 0) && yearm == year) {
                    value = 0;
                  } else if ((monthm - month == 1) && yearm == year) {
                    value = 1;
                  } else if ((monthm - month >= 1 && monthm - month <= 3) &&
                      yearm == year) {
                    value = 3;
                  } else if ((monthm - month >= 3 && monthm - month <= 6) &&
                      yearm == year) {
                    value = 6;
                  } else if (yearm - year == 1 && month - monthm == 11) {
                    value = 1;
                  } else {
                    value = -1;
                  }
                  print("value $value");
                  if (value == 00 && _currentIndex == 0) {
                    addData(Memberlist, size);
                  } else if ((value == 01) && _currentIndex == 1){
                    addData(Memberlist, size);
                  }
                  else if ((value <= 03 && value > 01) && _currentIndex == 2){
                    addData(Memberlist, size);
                  }
                  else if ((value <= 06 && value > 03) && _currentIndex == 3){
                    addData(Memberlist, size);
                  }
                }
                return _isloading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                                height: size.height * 0.68,
                                child: ListView.builder(
                                  itemCount: Memberlist.length,
                                  itemBuilder: (context, i) => Memberlist[i],
                                )),
                          ],
                        ),
                      );
              }),
*/