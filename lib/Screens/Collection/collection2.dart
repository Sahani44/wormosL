// ignore_for_file: non_constant_identifier_names, no_logic_in_create_state, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:internship2/Providers/scheme_selector.dart';
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
  late int totalCollection = 0;
  late int totalAmountCollected = 0;
  late String place;
  int totalClient = 0;
  String dropdownvalue ='Name';
  String dropdownvalue1 = 'Member_Name';
  var items = ['Name' ,'DOE'];
  late Timestamp payment_date;
  String accountType = '';
  String Type = '';
  var _isloading = false;
  late final _firestone = FirebaseFirestore.instance;
  int _currentIndex = 0;
  final _inactiveColor = const Color(0xffEBEBEB);
  var tiles =[];
  List<Widget> Memberlist = [];
  
  void addData(List<Widget> Memberlist) {
    Memberlist.add(
      due_data(
        Location: Location,
        Member_Name: Member_Name,
        Plan: Plan,
        Account_No: Account_No,
        date_mature: date_mature,
        date_open: date_open, 
        Monthly: Monthly,
        Type: Type, 
        payment_date: payment_date, 
        Amount_Remaining: Amount_Remaining, 
        total_installment: total_installment, 
        paid_installment: paid_installment, 
        mode: mode, 
        status: status, 
        Amount_Collected: Amount_Collected,
        accountType: accountType,
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
  @override
  Widget build(BuildContext context) {
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
    totalClient = 0;
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
          StreamBuilder(
            stream: 
            (Location == '5 Days' || Location == 'Monthly') 
            ? (Plan == '')
                ? _firestone
                  .collection('new_account')
                  .where('Type',isEqualTo: widget.Location)
                  .snapshots()
                :_firestone
                  .collection('new_account')
                  .where('Type',isEqualTo: widget.Location)
                  .where('Plan', isEqualTo: Plan)
                  .snapshots()
            : (Plan == '')
                ?_firestone
                  .collection('new_account_d')
                  .where('place',isEqualTo: widget.Location)
                  .snapshots()
                : _firestone
                  .collection('new_account_d')
                  .where('place',isEqualTo: widget.Location)
                  .where('Plan', isEqualTo: Plan)
                  .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              Iterable tiles1 = {};
              tiles1 = snapshot.data!.docs;
              for (var tile in tiles1) {
                totalCollection += tile.get('monthly')! as int;
                totalAmountCollected += tile.get('Amount_Remaining')! as int;
                totalClient += 1;
              }
              return _isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : amountdata(totalCollection, totalAmountCollected, totalClient);
            }
            ),
           _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              SizedBox(
                  height: size.height * 0.68,
                  child: ListView.builder(
                    itemCount: Memberlist.length,
                    itemBuilder: (context, i) {
                      var plan = tiles[i].get('Plan');
                      var type = tiles[i].get('Type');
                      var loc = tiles[i].get('place');
                      Widget widget = const SizedBox(height: 0,);
                
                      if (Location == type) {
                        if (_currentIndex == 1 && plan == 'A') {
                          widget =  Memberlist[i] ;
                        } 
                        if (_currentIndex == 2 && plan == 'B') {
                            widget =  Memberlist[i];
                        }
                        if( _currentIndex == 0) {
                          widget =  Memberlist[i];
                        }
                      }
                      else {
                        if (_currentIndex == 1 && plan == 'A' && Location == loc) {
                          widget =  Memberlist[i] ;
                        } 
                        if (_currentIndex == 2 && plan == 'B' && Location == loc) {
                            widget =  Memberlist[i];
                        }
                        if( _currentIndex == 0 && Location == loc) {
                          widget =  Memberlist[i];
                        }
                      }
                      return widget;
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

  Widget amountdata(int totalCollection1, int totalAmountCollected1, int totalClient1) {
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
                child: Text('$totalClient1')
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
}
