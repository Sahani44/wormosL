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
  late int monthly;
  bool _isloading = true;
  late String type;
  late int total_installment;
  late int Amount_Remaining;
  late int Amount_Collected;
  late List<Timestamp>  payment_dates;
  late int paid_installment;
  late String place;
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
  
  void addData(List<Widget> Memberlist) {
    Memberlist.add(
      displayeddata(
        Location: place,
        Member_Name: Member_Name,
        Plan: Plan,
        Account_No: Account_No,
        date_mature: date_mature,
        date_open: date_open, 
        monthly: monthly,
        type: type, 
        payment_dates: payment_dates, 
        Amount_Remaining: Amount_Remaining, 
        total_installment: total_installment, 
        paid_installment: paid_installment,
      ),
    );
  }

  Future<bool> getDocs (Memberlist) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestone.collection("deleted_accounts").get();
    tiles = querySnapshot.docs.toList();
    for (var tile in tiles) {
      Member_Name = tile.get('Member_Name');
      Plan = tile.get('Plan');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      payment_dates = List<Timestamp>.from(tile.get('payment_dates'));
      type = tile.get('Type');
      place = tile.get('place');
      monthly = tile.get('monthly');
      Account_No = tile.get('Account_No').toString();
      date_open = tile.get('Date_of_Opening');
      date_mature = tile.get('Date_of_Maturity');
      totalClient += 1;
      totalAmount += Amount_Collected;
      totalBalance += Amount_Remaining;
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
    Size size = MediaQuery.of(context).size;
    // newMemberList = [];
    // totalClient = 0;
    // totalAmount = 0;
    // totalBalance = 0;
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
    );
  }

}
