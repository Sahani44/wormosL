// ignore_for_file: camel_case_types, non_constant_identifier_names, no_logic_in_create_state

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship2/widgets/button.dart';
import 'package:internship2/widgets/bottom_circular_button.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class due_data extends StatefulWidget {
  const due_data({
    super.key,
    required this.size,
    required this.date_open,
    required this.date_mature,
    required this.Account_No,
    required this.Member_Name,
    required this.Plan,
    required this.mode,
    required this.paid_installment,
    required this.total_installment,
    required this.status,
    required this.Type,
    required this.Location,
    required this.Amount_Collected,
    required this.Amount_Remaining,
    required this.Monthly,
    required this.payment_date,
    required this.accountType,
  });
  final String Member_Name;
  final String Plan;
  final String Account_No;
  final Timestamp date_open;
  final Timestamp date_mature;
  final Timestamp payment_date;
  final Size size;
  final String mode;
  final int paid_installment;
  final int total_installment;
  final String status;
  final String Type;
  final String Location;
  final int Amount_Collected;
  final int Amount_Remaining;
  final int Monthly;
  final String accountType;
  @override
  State<due_data> createState() => _due_dataState(
        size: size,
        Member_Name: Member_Name,
        Plan: Plan,
        Account_No: Account_No,
        date_mature: date_mature,
        date_open: date_open,
        mode: mode,
        paid_installment: paid_installment,
        total_installment:total_installment,
        status: status,
        Type: Type,
        Location: Location,
        Amount_Collected: Amount_Collected,
        Amount_Remaining: Amount_Remaining,
        Monthly: Monthly,
        payment_date: payment_date,
      );
}

class _due_dataState extends State<due_data> {

  _due_dataState({
    required this.size,
    required this.date_open,
    required this.date_mature,
    required this.Account_No,
    required this.Member_Name,
    required this.Plan,
    required this.mode,
    required this.payment_date,
    required this.Type,
    required this.paid_installment,
    required this.total_installment,
    required this.status,
    required this.Location,
    required this.Amount_Collected,
    required this.Amount_Remaining,
    required this.Monthly,
  });
  String _toggleValue2 = 'cash';
  bool _toggleValue1 = false;
  final String Type;
  final String Member_Name;
  final String Plan;
  final String Account_No;
  final Timestamp date_open;
  final Timestamp date_mature;
  final Size size;
  Timestamp payment_date;
  final int Amount_Collected;
  int Amount_Remaining;
  int Monthly;
  String mode;
  int paid_installment;
  int total_installment;
  String status;
  late int money = Monthly;
  final String Location;
  Color colour = const Color(0xffD83F52);
  final _firestone = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dateo =
        DateTime.fromMillisecondsSinceEpoch(date_open.millisecondsSinceEpoch);
    final yearo = dateo.year;
    final montho = dateo.month;
    final dayo = dateo.day;
    final datem =
        DateTime.fromMillisecondsSinceEpoch(date_mature.millisecondsSinceEpoch);
    final yearm = datem.year;
    final monthm = datem.month;
    final daym = datem.day;
    DateTime now = DateTime.now();
    // if (now.day-payment_date.toDate().day == 1) {
    //   status = 'Due';
    //   colour = const Color(0xffD83F52);
    //   setState(() {});
    // }
    // int Daily = (Monthly / 30).floor();
    // int Weekly = (Monthly / 4).floor();
    if(Type == 'Daily') {
      if (now.day-payment_date.toDate().day >= 1 || now.month-payment_date.toDate().month >= 1) {
      status = 'Due';
      colour = const Color(0xffD83F52);
      // setState(() {});
    }
      money = (now.day>30 ? 30*(Monthly / 30).floor()-Amount_Remaining : now.day*(Monthly / 30).floor()-Amount_Remaining);
    }
    if (Type == '5 Days'){
      if (now.day-payment_date.toDate().day >= 5) {
      status = 'Due';
      colour = const Color(0xffD83F52);
      // setState(() {});
    }
      money = (Monthly / 6).floor()*((now.day-payment_date.toDate().day)%5);
    }
    if (Type == 'Monthly'){
      money = Monthly - Amount_Remaining;
      if(money > 0){
        status = 'Due';
      }
      else {
        status = 'Paid';
      }
    } 
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 0.0, left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    Member_Name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    Account_No,
                    style: const TextStyle(color: Color(0xffAF545F), fontSize: 13.0),
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  if(status == 'Due'){
                    status = 'Paid';
                    payment_date = Timestamp.now();
                    if (paid_installment >total_installment) paid_installment = 0;
                  _firestone
                      .collection(widget.accountType)
                      .doc(Account_No)
                      .update({
                    'status': status,
                    'mode': mode,
                    'payment_date': now,
                    'Amount_Collected': Amount_Collected + money,
                    'Amount_Remaining': Amount_Remaining + money,
                  });

                  if(Amount_Remaining + money >= Monthly){
                    paid_installment++;
                    _firestone
                      .collection(widget.accountType)
                      .doc(Account_No)
                      .update({
                        'Amount_Remaining': Amount_Remaining + money - Monthly,
                        'paid_installment': paid_installment,
                      });
                  }
                  setState(() {
                    colour = const Color(0xff29756F);
                    if(Amount_Remaining + money >= Monthly){
                      Amount_Remaining = Amount_Remaining + money - Monthly;
                    }
                    else{
                      Amount_Remaining += money;
                    }
                  });
                  }
                  else {}
                },
                child: button(
                    size: widget.size.width * 0.3,
                    text: status == 'Due' ? status : '$status/Undo',
                    color: status == 'Paid'
                        ? const Color(0xff29756F)
                        : const Color(0xffD83F52)),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 20.0, right: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 216, 216),
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: Alignment.center,
                width: widget.size.width*0.3,
                height: widget.size.height*0.030,
                child: Text('${payment_date.toDate().day}/${payment_date.toDate().month}/${payment_date.toDate().year}',style: const TextStyle(color: Colors.red,fontStyle: FontStyle.italic),),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
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
                        width: widget.size.width * 0.03,
                      ),
                      Text('$dayo/$montho/$yearo')
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
                        width: widget.size.width * 0.03,
                      ),
                      Text('$daym/$monthm/$yearm')
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Visibility(
                      visible: status == 'Paid' ? false : true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'CASH',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(width: 5),
                                  FlutterSwitch(
                                    activeColor: const Color(0xff1E8829),
                                    inactiveColor: const Color(0xff1E8829),
                                    width: size.width * 0.07,
                                    height: size.height * 0.018,
                                    valueFontSize: size.height * 0.018,
                                    toggleSize: size.height * 0.018,
                                    value: _toggleValue1,
                                    borderRadius: 30.0,
                                    // padding: 8.0,
                                    showOnOff: false,
                                    onToggle: (val) {
                                      setState(() {
                                        if (val == true) {
                                          _toggleValue2 = 'cash';
                                          _toggleValue1 = val;
                                        } else {
                                          _toggleValue2 = 'online';
                                          _toggleValue1 = val;
                                        }
                                        mode = _toggleValue2;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'ONLINE',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.height * 0.2,
                          ),
                        ]
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
                                child: Text('$Amount_Remaining'),
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
                                    onSubmitted: (value) {
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
                  )
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
                        width: widget.size.width * 0.03,
                      ),
                      Text('$Monthly/-'),
                      SizedBox(
                        width: widget.size.width * 0.18,
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
                        width: widget.size.width * 0.01,
                      ),
                      Text(
                        '$paid_installment/$total_installment',
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
                      .collection(widget.accountType)
                      .doc(Account_No)
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
                        .doc(Location)
                        .collection(Location)
                        .doc(Account_No)
                        .delete();
                  });
                },
                size: 20,
                icon: Image.asset('assets/Acc/IC5.png'),
              ),
            ],
          ),
        ),
        // ),
        const Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Divider(
            thickness: 0.7,
            height: 0.02,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}





