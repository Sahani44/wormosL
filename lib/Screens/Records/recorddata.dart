// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Screens/Records/view.dart';
import 'package:internship2/widgets/button.dart';
import 'package:internship2/widgets/bottom_circular_button.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class record_data extends StatefulWidget {
  const record_data({
    super.key,
    required this.date_open,
    required this.date_mature,
    required this.Account_No,
    required this.Member_Name,
    required this.Plan,
    required this.installment,
    required this.status,
    required this.Location,
    required this.Amount_Collected,
    required this.Amount_Remaining,
    required this.Monthly,
    required this.history,
    required this.date,
  });
  final String Member_Name;
  final String Plan;
  final String Account_No;
  final Timestamp date_open;
  final Timestamp date_mature;
  final int installment;
  final String status;
  final String Location;
  final int Amount_Collected;
  final int Amount_Remaining;
  final int Monthly;
  final Map<String, Map<String,dynamic>> history; 
  final String date;

  @override
  State<record_data> createState() => _record_dataState();
}

class _record_dataState extends State<record_data> {
  _record_dataState();
 
  // String _toggleValue2 = 'cash';
  // bool _toggleValue1 = false;
  final _firestone = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 10, bottom: 10.0, left: 20.0, right: 20.0),
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
                    widget.Account_No.toString(),
                    style: const TextStyle(
                        color: Color(0xffAF545F), fontSize: 13.0),
                  ),
                ],
              ),
              button(
                size: size.width * 0.3,
                text: 'Paid ${widget.history[widget.date]!['payment_amount']}',
                color: const Color(0xff29756F),
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
                      Text('${widget.date_open.toDate().day}/${widget.date_open.toDate().month}/${widget.date_open.toDate().year}')
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
                      Text('${widget.date_mature.toDate().day}/${widget.date_mature.toDate().month}/${widget.date_mature.toDate().year}')
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.12,
                        child: const Text(
                          "Balance",
                          style: TextStyle(
                            color: Color(0xffaf545f),
                            fontSize: 11,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        width: size.width * 0.15,
                        height: size.height * 0.023,
                        color: const Color(0x35979797),
                        child: Center(
                          child: Text(
                            widget.Amount_Remaining.toString(),
                            style: const TextStyle(
                              color: Color(0xaa000000),
                              fontSize: 12,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
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
              Text(
                'Monthly - ${widget.Monthly}',
                style: const TextStyle(
                  fontSize: 13.5,
                  color: Color(0xffAF545F),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Text(
                '${widget.installment.toString()}/60',
                style: const TextStyle(
                  fontSize: 13.5,
                  color: Color(0xffAF545F),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        // Padding(
        // padding: const EdgeInsets.all(8.0),
        // child:
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
                      .doc(widget.Account_No)
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
              // circular_button(
              //   size: 20,
              //   icon: Image.asset('assets/Acc/IC4.png'),
              // ),
              circular_button(
                onpressed: () {
                  print("hello");
                  setState(() {
                    _firestone
                        .collection('new_account')
                        .doc(widget.Account_No)
                        .delete();
                  });
                },
                size: 20,
                icon: Image.asset('assets/Acc/IC5.png'),
              ),
              SizedBox(
                width: size.width * 0.1,
              ),
              FloatingActionButton.extended(
                heroTag: widget.Account_No,
                label: const Text('View'),
                backgroundColor: const Color.fromARGB(255, 109, 113, 245),
                onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewTable(history: widget.history)),
              ),
              )
            ],
          ),
        ),
        // ),
        const Divider(
          thickness: 0.7,
          height: 0.02,
        )
      ],
    );
  }
}
