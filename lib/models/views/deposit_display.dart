// ignore_for_file: non_constant_identifier_names, must_be_immutable, camel_case_types

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Screens/Home/home_functions.dart';
import 'package:internship2/widgets/button.dart';
import 'package:internship2/widgets/bottom_circular_button.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class deposit_data extends StatefulWidget {
  deposit_data({
    Key? key,
    required this.date_open,
    required this.deposit_field,
    required this.date_mature,
    required this.Account_No,
    required this.Member_Name,
    required this.Plan,
    required this.paid_installment,
    required this.total_installment,
    required this.Location,
    required this.Amount_Collected,
    required this.Amount_Remaining,
    required this.Monthly,
    required this.history,
    required this.accountType,
    required this.callBack,
    required this.id,
  }) : super(key: key);

  final String Member_Name;
  final String Plan;
  final String Account_No;
  final String id;
  final Timestamp date_open;
  final Timestamp date_mature;
  SplayTreeMap<String, Map<String,dynamic>> history;
  final int paid_installment;
  final int total_installment;
  final String Location;
  final String accountType;
  final bool deposit_field;
  final dynamic Amount_Collected;
  final dynamic Amount_Remaining;
  final int Monthly;
  var callBack;

  @override
  State<deposit_data> createState() => _deposit_dataState();
}

class _deposit_dataState extends State<deposit_data> {
  late int money = 0;
  Color colour = const Color(0xffD83F52);
  final _firestone = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dateo = widget.date_open.toDate();
    final datem = widget.date_mature.toDate();
    // int deposit_field = 0;
    // if(widget.Monthly == widget.Amount_Remaining) {
    //   deposit_field = 0;
    // } else if() {
    //   deposit_field = 1;
    // }

    // DateTime now = DateTime.now();
    // int Daily = (widget.Monthly / 30).floor();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    widget.Member_Name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.Account_No,
                    style: const TextStyle(color: Color(0xffAF545F), fontSize: 13.0),
                  ),
                ],
              ),
              // if (widget.deposit_field)
              //   MaterialButton(
              //     onPressed: () {
              //       setState(() {
              //         // deposit_field = false;
              //       });

              //       // _firestone
              //       //     .collection(widget.accountType)
              //       //     .doc(widget.Account_No)
              //       //     .update({
              //       //   'deposit_field': false,
              //       // });
              //       widget.callBack();
              //       // Navigator.pushReplacement(
              //       //   context,
              //       //   MaterialPageRoute(
              //       //     builder: (context) => const deposit_screen(),
              //       //   ),
              //       // );
              //     },
              //     child: button(
              //       size: size.width * 0.3,
              //       text: 'Deposited',
              //       color: const Color(0xff353CE5),
              //     ),
              //   ),
                if (widget.Monthly <= widget.Amount_Remaining)
                MaterialButton(
                  onPressed: () {
                    int rem = widget.Amount_Remaining%widget.Monthly;
                    showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Making Payment?'),
                      content: money == 0 ? Text('Tap on OK to complete deposit of ${widget.Amount_Remaining-rem} for ${widget.Member_Name}') : Text('Tap on OK to complete deposit of $money for ${widget.Member_Name}'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                            // deposit_field = true;
                            });
                            if (money == 0)
                            {   
                              _firestone
                              .collection(widget.accountType)
                              .doc(widget.id)
                              .update({
                                'Amount_Remaining': rem,
                                'Amount_Collected':widget.Amount_Collected+widget.Amount_Remaining-rem,
                                'deposit_field': true,
                              });
                              updateSummary('${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}', widget.Plan == 'A'?0:1, widget.Amount_Remaining-rem);
                            }
                            else{
                              _firestone
                              .collection(widget.accountType)
                              .doc(widget.id)
                              .update({
                                'Amount_Remaining': widget.Amount_Remaining-money,
                                'Amount_Collected': widget.Amount_Collected+money,
                                'deposit_field': true,
                              });
                              updateSummary('${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}', widget.Plan == 'A'?0:1, money);
                            }
                            widget.callBack();
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const deposit_screen(),
                            //   ),
                            // );
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  },
                  child: button(
                    size: size.width * 0.3,
                    text: 'Deposit',
                    color: const Color(0xff353CE5),
                  ),
                ),
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(
              top: 0, bottom: 10.0, left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'DOO',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Color(0xffAF545F),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text('${dateo.day}/${dateo.month}/${dateo.year}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'DOM',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Color(0xffAF545F),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text('${datem.day}/${datem.month}/${datem.year}'),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 218, 216, 216),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          width: size.width*0.3,
                          height: size.height*0.030,
                          child: Text('${DateTime.parse(widget.history.keys.last).day}/${DateTime.parse(widget.history.keys.last).month}/${DateTime.parse(widget.history.keys.last).year}',style: const TextStyle(color: Colors.red,fontStyle: FontStyle.italic),),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Balance', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                      SizedBox(width: size.width* 0.015,),
                      Container(
                        height: size.height * 0.035,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Center(
                            child: Text('${widget.Amount_Remaining}'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.015,
                      ),
                      Container(
                        height: size.height * 0.035,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 11.0, 0.0, 0.0),
                          child: Center(
                            child: TextField(
                              keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.left,
                                onChanged: (value) {
                                  money = int.parse(value);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '$money',
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 0, bottom: 10.0, left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Monthly',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Color(0xffAF545F),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width:size.width * 0.03,
                      ),
                      Text('${widget.Monthly}/-'),
                      SizedBox(
                        width: size.width * 0.18,
                      ),
                      const SizedBox(
                        child: Wrap(
                          children: [
                            Text(
                              'Installments',
                              style: TextStyle(
                                fontSize: 13.5,
                                color: Color(0xffAF545F),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        '${widget.paid_installment}/${widget.total_installment}',
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              circular_button(
                onpressed: () {
                  print("hello");
                  String phoneNo = ""; // Nullable variable

                  _firestone
                      .collection('new_account')
                      .doc(widget.id)
                      .get()
                      .then((DocumentSnapshot<Map<String, dynamic>>
                          documentSnapshot) {
                    if (documentSnapshot.exists) {
                      var data = documentSnapshot.data();
                      if (data != null) {
                        phoneNo = data['Phone_No'];
                        print(phoneNo);

                        if (phoneNo.isNotEmpty) {
                          launchUrl(Uri.parse("tel:+91$phoneNo"));
                        } else {
                          print('Phone number is empty');
                        }
                      }
                    } else {
                      print('Document does not exist in the database');
                    }
                  }).catchError((error) {
                    print('Error retrieving document: $error');
                  });
                },
                size: 20,
                icon: Image.asset('assets/Acc/IC2.png'),
              ),
              circular_button(
                onpressed: () {
                  print("hello");
                  setState(() {
                    _firestone
                        .collection('new_account')
                        .doc(widget.Location)
                        .collection(widget.Location)
                        .doc(widget.Account_No)
                        .delete();
                  });
                },
                size: 20,
                icon: Image.asset('assets/Acc/IC5.png'),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15,right: 15),
          child: Divider(
            thickness: 0.7,
            height: 0.02,
            color: Colors.black,
          ),
        ),
      ],
    );
  
  }
}
