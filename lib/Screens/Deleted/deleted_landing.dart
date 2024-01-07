// ignore_for_file: non_constant_identifier_names, camel_case_types, no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import '../../models/views/displayed_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/amountdata.dart';

class deleted_landing extends StatefulWidget {
  static const id = '/deleted_landing';
  const deleted_landing( {super.key});
  @override
  State<deleted_landing> createState() => _deleted_landingState();
}

class _deleted_landingState extends State<deleted_landing> {

  late String Member_Name;
  late String Plan;
  late String Account_No;
  late Timestamp date_open;
  late Timestamp date_mature;
  late Timestamp ndd;
  late int monthly;
  bool _isloading = true;
  late String type;
  late int total_installment;
  late int Amount_Remaining;
  late int Amount_Collected;
  late Map<String, Map<String,dynamic>> history;
  late int paid_installment;
  late String place;
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
  late String add;
  late String phone;
  late String cif;
  late var id;
  final myController = TextEditingController();
  
  void addData() {
    Memberlist.add(
      displayeddata(
        callback: callBack,
        accountType: place == '' ? 'new_account' : 'new_account_d',
        deleted: true,
        Location: place,
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
        id:id,
        ndd: ndd
      ),
    );
  }

  Future<bool> getDocs () async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestone.collection("deleted_accounts").get();
    tiles = querySnapshot.docs.toList();
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
      phone = tile.get('Phone_No');
      cif = tile.get('CIF_No');
      add = tile.get('Address');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      history = Map<String, Map<String,dynamic>>.from(tile.get('history'));
      type = tile.get('Type');
      place = tile.get('place');
      monthly = tile.get('monthly');
      Account_No = tile.get('Account_No').toString();
      date_open = tile.get('Date_of_Opening');
      date_mature = tile.get('Date_of_Maturity');
      ndd = tile.get('next_due_date');
      totalClient += 1;
      totalAmount += monthly;
      totalBalance += Amount_Remaining;
      addData();
    }
  }

  callBack() {
      Memberlist = [];
      getDocs().then((value) => setState(() {
      _isloading = value;
    }));
  }

  @override
  void initState() {
    super.initState();
    getDocs().then((value) => setState(() {
      _isloading = value;
    }));
  }

  void getAmountData(){
    for (int i=0; i<newTiles.length; i++) {
      int ac = newTiles[i].get('monthly');
      int ar = newTiles[i].get('Amount_Remaining');
      totalClient += 1;
      totalAmount += ac;
      totalBalance += ar;
    }
  }

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
    totalClient = 0;
    totalAmount = 0;
    totalBalance = 0;
    getAmountData();
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
            amountdata(totalClient, totalAmount,  totalBalance, context),
            _isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
              children: [
                SizedBox(
                    height: size.height * 0.81,
                    child: ListView.builder(
                      itemCount: Memberlist.length,
                      itemBuilder: (context, i) {
                        return Memberlist[i];
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

}
