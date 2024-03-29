// ignore_for_file: camel_case_types, non_constant_identifier_names, no_logic_in_create_state, avoid_print, must_be_immutable

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Screens/Account/client_dtbase.dart';
import 'package:internship2/Screens/Home/home_functions.dart';
import 'package:internship2/widgets/button.dart';
import 'package:internship2/widgets/bottom_circular_button.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class due_data extends StatefulWidget {

  due_data({
    super.key,
    required this.date_open,
    required this.date_mature,
    required this.Account_No,
    required this.Member_Name,
    required this.Plan,
    required this.paid_installment,
    required this.total_installment,
    required this.status,
    required this.Type,
    required this.Location,
    required this.Amount_Collected,
    required this.Amount_Remaining,
    required this.Monthly,
    required this.history,
    required this.accountType,
    required this.callBack,
    required this.next_due_date,
    required this.cif, 
    required this.add, 
    required this.phone,
    required this.id,
    required this.place,
    required this.df
  });
  final String Member_Name;
  final String Plan;
  final String Account_No;
  final Timestamp date_open;
  final Timestamp date_mature;
  Timestamp next_due_date;
  final SplayTreeMap<String, Map<String,dynamic>> history;
  int paid_installment;
  final int total_installment;
  final String status;
  final String Type;
  final String Location;
  late int Amount_Collected;
  late int Amount_Remaining;
  final int Monthly;
  final String accountType;
  final String add;
  final String phone;
  final String cif;
  final String place;
  final bool df;
  var callBack;
  var id;

  @override
  State<due_data> createState() => _due_dataState();
}

class _due_dataState extends State<due_data> {

  String _toggleValue2 = 'cash';
  bool _toggleValue1 = false;
  late String status = widget.status;
  late int money = widget.Monthly;
  String mode = 'cash';
  Color colour = const Color(0xffD83F52);
  final _firestone = FirebaseFirestore.instance;
  DateTime new_payment_date = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
    // DateTime now = DateTime.now();
    // if (now.day-payment_date.toDate().day == 1) {
    //   status = 'Due';
    //   colour = const Color(0xffD83F52);
    //   setState(() {});
    // }
    // int Daily = (Monthly / 30).floor();
    // int Weekly = (Monthly / 4).floor();
    if(widget.Type == 'Daily') {
      money = (widget.Monthly/30).floor();
      // if (now.day-widget.history[widget.history.length-1]['payment_date'].toDate().day >= 1 || now.month-widget.history[widget.history.length-1]['payment_date'].toDate().month >= 1) {
      if(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).isAfter(DateTime.parse(widget.history.keys.last)) && (widget.Amount_Collected >0 && widget.Amount_Remaining !=0) && widget.Monthly > widget.Amount_Remaining){
        status = 'Due';
        // colour = const Color(0xffD83F52);
        // setState(() {});
      } else {
        status = "Paid";
      }
    }
    if (widget.Type == '5 Days'){
      // if (now.day-widget.history[widget.history.length-1]['payment_date'].toDate().day >= 1) 
      if(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).isAfter(DateTime.parse(widget.history.keys.last)) && (widget.Amount_Collected >0 && widget.Amount_Remaining !=0) && widget.Monthly > widget.Amount_Remaining){
        status = 'Due';
        // colour = const Color(0xffD83F52);
        // setState(() {});
      } else {
        status = "Paid";
      }
      money = (widget.Monthly / 6).floor();
    }
    if (widget.Type == 'Monthly'){
      money = widget.Monthly;
      if(widget.Monthly == widget.Amount_Remaining){
        status = 'Paid';
      }
      else {
        status = 'Due';
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
              MaterialButton(
                onPressed: () {
                  
                    showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Making Payment?'),
                      content: Text('Tap on OK to complete payment of $money for ${widget.Member_Name}'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () { 
                           status = 'Paid';
                              widget.history.addAll({
                                '${new_payment_date.year}-${new_payment_date.month < 10 ? '0${new_payment_date.month}' : new_payment_date.month}-${new_payment_date.day < 10 ? '0${new_payment_date.day}' : new_payment_date.day}' : {
                                  'payment_mode' : mode,
                                  'payment_amount' : money,
                                }
                              });
                              _firestone
                                .collection('records')
                                .doc('${new_payment_date.year}-${new_payment_date.month < 10 ? '0${new_payment_date.month}' : new_payment_date.month}-${new_payment_date.day < 10 ? '0${new_payment_date.day}' : new_payment_date.day}')
                                .set({widget.Account_No : {
                                  'coll' : money,
                                  'place' : widget.place == '' ? widget.Type : widget.place,
                                  'plan' : widget.Plan
                                }}, SetOptions(merge: true));                      

                              if (widget.paid_installment >widget.total_installment) widget.paid_installment = 0;
                            _firestone
                                .collection(widget.accountType)
                                .doc(widget.id)
                                .update({
                              'history': widget.history,
                              'status': status,
                              'Amount_Remaining': widget.Amount_Remaining + money,
                            });
                            // widget.Amount_Remaining += money; 
                            if(widget.Amount_Remaining + money>= widget.Monthly){
                              DateTime nndd = DateTime(widget.next_due_date.toDate().year, widget.next_due_date.toDate().month - (widget.Amount_Remaining/widget.Monthly).floor() + ((widget.Amount_Remaining + money)/widget.Monthly).floor(), widget.next_due_date.toDate().day);
                              widget.paid_installment += (((widget.Amount_Remaining+money)/widget.Monthly).floor() - (widget.Amount_Remaining/widget.Monthly).floor());
                              _firestone
                                .collection(widget.accountType)
                                .doc(widget.id)
                                .update({
                                  'paid_installment': widget.paid_installment,
                                  'Amount_Remaining': widget.Amount_Remaining+money,
                                  'next_due_date' : nndd,
                                });
                            }
                            updateSummary('${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}', 6, money);
                            setState(() {
                              colour = const Color(0xff29756F);
                              // if(Amount_Remaining + money >= Monthly){
                              //   Amount_Remaining = Amount_Remaining + money - Monthly;
                              // }
                              // else{
                              //   Amount_Remaining += money;
                              // }
                            });
                            widget.callBack();
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
                    text: status,
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
                width: size.width*0.3,
                height: size.height*0.030,
                child: Text('${DateTime.parse(widget.history.keys.last).day}/${DateTime.parse(widget.history.keys.last).month}/${DateTime.parse(widget.history.keys.last).year}',style: const TextStyle(color: Colors.red,fontStyle: FontStyle.italic),),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        'NDD',
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
                      Text('${widget.next_due_date.toDate().day}/${widget.next_due_date.toDate().month}/${widget.next_due_date.toDate().year}')
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
                  ),
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
                                          _toggleValue2 = 'online';
                                          _toggleValue1 = val;
                                        } else {
                                          _toggleValue2 = 'cash';
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
                      Text('${widget.Monthly}/-'),
                      SizedBox(
                        width: size.width * 0.18,
                      ),
                      Column(
                        children: [
                          Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month_rounded),
                            Container(
                              height: size.height * 0.045,
                              width: size.width * 0.25,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Center(
                                  child: TextButton(
                                      onPressed: () async {
                                        DateTime? newPaymentDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: new_payment_date,
                                                firstDate: DateTime(1990),
                                                lastDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day));
                                        if (newPaymentDate == null) return;
          
                                        setState(() => new_payment_date = newPaymentDate);
                                      },
                                      child: Text(
                                          style: const TextStyle(
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.left,
                                          '${new_payment_date.day}/${new_payment_date.month}/${new_payment_date.year}')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [const SizedBox(
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
                      ),],
                      )
                        ],
                      )
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
                  if (widget.phone.isNotEmpty) {
                          launchUrl(Uri.parse("tel:+91${widget.phone}"));
                        } else {
                          print('Phone number is empty');
                        }
                  // print("hello");
                  // String phoneNo = ""; // Nullable variable

                  // _firestone
                  //     .collection(widget.accountType)
                  //     .doc(widget.Account_No)
                  //     .get()
                  //     .then((DocumentSnapshot<Map<String, dynamic>>
                  //         documentSnapshot) {
                  //   if (documentSnapshot.exists) {
                  //     var data = documentSnapshot.data();
                  //     if (data != null) {
                  //       phoneNo = data['Phone_No'];
                  //       print(phoneNo);

                  //       if (phoneNo.isNotEmpty) {
                  //         launchUrl(Uri.parse("tel:+91$phoneNo"));
                  //       } else {
                  //         print('Phone number is empty');
                  //       }
                  //     }
                  //   } else {
                  //     print('Document does not exist in the database');
                  //   }
                  // }).catchError((error) {
                  //   print('Error retrieving document: $error');
                  // });
                },
                size: 20,
                icon: Image.asset('assets/Acc/IC2.png'),
              ),
              circular_button(
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Client_dbt(memberName: widget.Member_Name, acc: widget.Account_No, cif: widget.cif, doo: widget.date_open, dom: widget.date_mature, location: widget.Location, amtcltd: widget.Amount_Collected, amtrmn: widget.Amount_Remaining, add: widget.add, monthly: widget.Monthly, phone: widget.phone,plan: widget.Plan,id: widget.id,accType: widget.Type,callback: widget.callBack,ndd:widget.next_due_date)),
                  );
                },
                size: 20,
                icon: Image.asset('assets/Acc/IC4.png'),
              ),
              circular_button(
                onpressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Deleting Account ?'),
                      content: const Text('Tap on OK to shift this account to deleted accounts'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            _firestone
                                .collection(widget.accountType)
                                .doc(widget.id)
                                .get()
                                .then((DocumentSnapshot<Map<String, dynamic>>
                                    documentSnapshot) {
                              if (documentSnapshot.exists) {
                                var data = documentSnapshot.data();
                                if (data != null) {
                                  _firestone
                                    .collection('deleted_accounts')
                                    .doc(widget.id)
                                    .set(data);

                                  updateSummary('${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}', widget.Plan == 'A'?4:5, widget.Monthly, type: (widget.Location != '') ? widget.Location : widget.Type, bal: widget.Amount_Remaining, df: widget.df);
                                  _firestone
                                  .collection(widget.accountType)
                                  .doc(widget.id)
                                  .delete();

                                  widget.callBack();
                                }
                              } else {
                                print('Document does not exist in the database');
                              }
                            }).catchError((error) {
                              print('Error retrieving document: $error');
                            });
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
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





