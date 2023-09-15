// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internship2/Screens/deposit/deposit_screen.dart';
import 'package:internship2/widgets/button.dart';
import 'package:internship2/widgets/bottom_circular_button.dart';
import 'package:flutter_switch/flutter_switch.dart';
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
  }) : super(key: key);

  final String Member_Name;
  final String Plan;
  final String Account_No;
  final Timestamp date_open;
  final Timestamp date_mature;
  List<Map<String,dynamic>> history;
  final int paid_installment;
  final int total_installment;
  final String Location;
  final bool deposit_field;
  final dynamic Amount_Collected;
  final dynamic Amount_Remaining;
  final int Monthly;

  @override
  State<deposit_data> createState() => _deposit_dataState();
}

class _deposit_dataState extends State<deposit_data> {
  String _toggleValue2 = 'cash';
  bool deposit = true;
  bool deposit_field = true;
  bool _toggleValue1 = false;
  late int money = 0;
  Color colour = const Color(0xffD83F52);
  final _firestone = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dateo = DateTime.fromMillisecondsSinceEpoch(
        widget.date_open.millisecondsSinceEpoch);
    final yearo = dateo.year;
    final montho = dateo.month;
    final dayo = dateo.day;
    final datem = DateTime.fromMillisecondsSinceEpoch(
        widget.date_mature.millisecondsSinceEpoch);
    final yearm = datem.year;
    final monthm = datem.month;
    final daym = datem.day;
    DateTime now = DateTime.now();
    int Daily = (widget.Monthly / 30).floor();

    return buildDepositTile(size, yearo, montho, dayo, yearm, monthm, daym);
  }

  Widget buildDepositTile(Size size, int yearo, int montho, int dayo, int yearm,
      int monthm, int daym) {
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
              if (widget.deposit_field)
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      deposit_field = false;
                    });

                    _firestone
                        .collection('new_account')
                        .doc(widget.Location)
                        .collection(widget.Location)
                        .doc(widget.Account_No)
                        .update({
                      'deposit_field': false,
                    });
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const deposit_screen(),
                    //   ),
                    // );
                  },
                  child: button(
                    size: size.width * 0.3,
                    text: 'Deposit',
                    color: const Color(0xff353CE5),
                  ),
                ),
                if (!widget.deposit_field)
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      deposit_field = true;
                    });

                    _firestone
                        .collection('new_account')
                        .doc(widget.Location)
                        .collection(widget.Location)
                        .doc(widget.Account_No)
                        .update({
                      'deposit_field': true,
                    });
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const deposit_screen(),
                    //   ),
                    // );
                  },
                  child: button(
                    size: size.width * 0.3,
                    text: 'Deposited/Undo',
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
                      Text('$yearo/$montho/$dayo'),
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
                      Text('$yearm/$monthm/$daym'),
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
                          child: Text('${widget.history[widget.history.length-1]['payment_date'].toDate().day}/${widget.history[widget.history.length-1]['payment_date'].toDate().month}/${widget.history[widget.history.length-1]['payment_date'].toDate().year}',style: const TextStyle(color: Colors.red,fontStyle: FontStyle.italic),),
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
        Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                circular_button(
                  onpressed: () {
                    print("hello");
                    String phoneNo = ""; // Nullable variable

                    _firestone
                        .collection('new_account')
                        .doc(widget.Location)
                        .collection(widget.Location)
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
