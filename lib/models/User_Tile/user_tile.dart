// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:internship2/Screens/Account/client_dtbase.dart';

class user_tile extends StatefulWidget {
  String Member_Name;
  String Plan;
  String Account_No;
  Timestamp date_open;
  Timestamp date_mature;
  Timestamp ndd;
  String Location;
  String type;
  int monthly;
  int Amount_Remaining;
  int Amount_Collected;
  String add;
  String phone;
  int total_installment;
  int paid_installment;
  String cif;
  var id;
  Map<String, Map<String,dynamic>> history;
  user_tile({
    Key? key,
    required this.Member_Name,
    required this.Plan,
    required this.Account_No,
    required this.date_open,
    required this.date_mature,
    required this.Location,
    required this.type,
    required this.monthly,
    required this.Amount_Remaining,
    required this.Amount_Collected,
    required this.add,
    required this.phone,
    required this.total_installment,
    required this.paid_installment,
    required this.cif,
    required this.history,
    required this.id,
    required this.ndd
  }) : super(key: key);
  
  @override
  State<user_tile> createState() => _user_tileState();
}

class _user_tileState extends State<user_tile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        selected: true,
        focusColor: const Color(0xff53927B),
        tileColor: Colors.white,
        selectedTileColor: const Color(0xff53927B),
        leading: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: size.height * 0.1,
          width: size.width * 0.14,
          child: Center(
            child: Text(
              widget.Member_Name[0],
              style: const TextStyle(
                  color: Color(0xff29756F),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        trailing: IconButton(
            onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Client_dbt(memberName: widget.Member_Name, acc: widget.Account_No, cif: widget.cif, doo: widget.date_open, dom: widget.date_mature, location: widget.Location, amtcltd: widget.Amount_Collected, amtrmn: widget.Amount_Remaining, add: widget.add, monthly: widget.monthly, phone: widget.phone, plan: widget.Plan,id:widget.id,accType: widget.type,callback: '',ndd:widget.ndd)),
            );},
            icon: const Icon(
              Icons.expand_circle_down_rounded,
              color: Colors.white,
            )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          widget.Member_Name,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          '${widget.monthly}/Month',
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
