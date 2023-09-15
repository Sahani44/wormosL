// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, camel_case_types, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:internship2/widgets/bottom_circular_button.dart';

import '../../Screens/Account/client_dtbase.dart';

class displayeddata extends StatefulWidget {
  
  final String Member_Name;
  final String Plan;
  final String Account_No;
  final Timestamp date_open;
  final Timestamp date_mature;
  final String Location;
  final String type;
  final int monthly;
  final int Amount_Remaining;
  final int total_installment;
  final int paid_installment;
  final List<Map<String,dynamic>> history;

  const displayeddata({
    Key? key,
    required this.Member_Name,
    required this.Plan,
    required this.Account_No,
    required this.date_open,
    required this.date_mature,
    required this.Location,
    required this.monthly,
    required this.type,
    required this.Amount_Remaining,
    required this.total_installment,
    required this.paid_installment,
    required this.history
  }) : super(key: key);

  @override
  State<displayeddata> createState() => _displayeddataState();
}

class _displayeddataState extends State<displayeddata> {

    final _firestone = FirebaseFirestore.instance;
    
    

  @override
  Widget build(BuildContext context) {
    late int? money = 0;
    DateTime now = DateTime.now();

     if(widget.type == 'Daily') {
      money = (now.day>30 ? 30*(widget.monthly / 30).floor()-widget.Amount_Remaining : now.day*(widget.monthly / 30).floor()-widget.Amount_Remaining);
    }
    if (widget.type == '5 Days'){
      money = ((widget.monthly / 6).floor()*((now.day-widget.history[widget.history.length-1]['payment_date'].toDate().day)%5)) as int?;
    }
    if (widget.type == 'widget.monthly'){
      money = (widget.monthly - widget.Amount_Remaining);
    } 
    Size size = MediaQuery.of(context).size;
    final dateo =
        DateTime.fromMillisecondsSinceEpoch(widget.date_open.millisecondsSinceEpoch);
    final yearo = dateo.year;
    final montho = dateo.month;
    final dayo = dateo.day;
    final datem =
        DateTime.fromMillisecondsSinceEpoch(widget.date_mature.millisecondsSinceEpoch);
    final yearm = datem.year;
    final monthm = datem.month;
    final daym = datem.day;
    String monthName = DateFormat('MMMM').format(dateo);
    final currentYear = DateFormat.y().format(dateo);

    // if (now.day-payment_date.toDate().day == 1) {
    //   status = 'Due';
    //   colour = const Color(0xffD83F52);
    //   setState(() {});
    // }
    // int Daily = (Monthly / 30).floor();
    // int Weekly = (Monthly / 4).floor();
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
                    widget.Member_Name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.Account_No,
                    style: const TextStyle(color: Color(0xffAF545F), fontSize: 13.0),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: Container(
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    color: const Color(0xff29756F),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                    border: Border.all(
                      width: 2,
                      color: const Color(0xff29756F),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '$monthName $currentYear',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
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
                width: size.width*0.3,
                height: size.height*0.030,
                child: Text('${widget.history[widget.history.length-1]['payment_date'].toDate().day}/${widget.history[widget.history.length-1]['payment_date'].toDate().month}/${widget.history[widget.history.length-1]['payment_date'].toDate().year}',style: const TextStyle(color: Colors.red,fontStyle: FontStyle.italic),),
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
                        width: size.width * 0.03,
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
                        width: size.width * 0.03,
                      ),
                      Text('$daym/$monthm/$yearm')
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                        width: size.width * 0.03,
                      ),
                      Text('${widget.monthly}/-'),
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
                      .collection('accountType')
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Client_dbt()),
                  );
                },
                size: 20,
                icon: Image.asset('assets/Acc/IC4.png'),
              ),
              circular_button(
                onpressed: () {
                  print("hello");
                  setState(() {
                    _firestone
                        .collection('accountType')
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
