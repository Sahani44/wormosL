// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names, camel_case_types, must_be_immutable

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:internship2/Screens/Place/newmember.dart';
import 'package:internship2/models/User_Tile/user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class user extends StatefulWidget {
  user(
    this.Place, {super.key}
  );
  String Place;
  static const id = '/user';
  @override
  State<user> createState() => _userState(Place);
}

class _userState extends State<user> {
  _userState(
    this.Place,
  );
  String Place;
  late String Member_Name;
  late String startdate;
  late String enddate;
  late String amt;
  late int monthly;
  late String Plan;
  late String phone;
  late String cif;
  late String add;
  late int paid_installment;
  late int total_installment;
  late int Amount_Remaining;
  late int Amount_Collected;
  late SplayTreeMap<String, Map<String,dynamic>> history;
  late String type; 
  late String Account_No;
  late Timestamp date_open;
  late Timestamp date_mature;
  late Timestamp ndd;
  List Memberlist = [];
  List tiles = [];
  List results = [];
  late var id;
  final _firestone = FirebaseFirestore.instance;
  var isloading = true;
  final myController = TextEditingController();

  Future<bool> getDocs () async {
    tiles = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = widget.Place == '5 Days' || widget.Place == 'Monthly' ?  await _firestone.collection( 'new_account').where('Type', isEqualTo: Place).get() : await _firestone.collection('new_account_d').where('place', isEqualTo: Place).get();
    tiles = querySnapshot.docs.toList();
    tiles.sort((a, b) {
       return a.get('Member_Name').compareTo(b.get('Member_Name'));
    },);
    createTiles(tiles);
    return false;
  }

  void createTiles(List nT){
    Memberlist = [];
    for (var tile in nT) {
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
      history = SplayTreeMap<String, Map<String,dynamic>>.from(tile.get('history'));
      type = tile.get('Type');
      monthly = tile.get('monthly');
      Account_No = tile.get('Account_No').toString();
      date_open = tile.get('Date_of_Opening');
      date_mature = tile.get('Date_of_Maturity');
      ndd = tile.get('next_due_date');
      Memberlist.add(user_tile(Member_Name: Member_Name, Plan: Plan, Account_No: Account_No, date_open: date_open, date_mature: date_mature, Location: widget.Place, type: type, monthly: monthly, Amount_Remaining: Amount_Remaining, Amount_Collected: Amount_Collected, add: add, phone: phone, total_installment: total_installment, paid_installment: paid_installment, cif: cif, history: history, id:id, ndd: ndd,));
    }
  }

  @override
  void initState() {
    super.initState();
    getDocs().then((value) => setState(() {
      isloading = value;
    }));
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
    
    createTiles(results);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Container(
          width: double.infinity,
          height: size.height * 0.05,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(18)),
          child: Center(
            child: TextField(
              controller: myController,
                onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: 
        SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.005,
          ),
          isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(
                      height: size.height,
                      child: ListView.builder(
                        itemCount: Memberlist.length,
                        itemBuilder: (context, i) => Memberlist[i],
                      )),
                ],
              )
        ]),
      ),
      floatingActionButton: SizedBox(
        width: size.width * 0.45,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => newmem(place: Place,)),
            );
          },
          backgroundColor: const Color(0xffA0205E),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: const Text(
            'Add Member',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
