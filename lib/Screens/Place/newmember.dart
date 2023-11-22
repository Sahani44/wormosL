// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:internship2/Screens/Home/home.dart';

class newmem extends StatefulWidget {
  static const String id = 'Newmem';
  final String place;

  const newmem({super.key, required this.place});
  
  @override
  State<newmem> createState() => _newmemState();
}

class _newmemState extends State<newmem> {
  late String Member_Name;
  String Plan = 'B';
  late String Account_No;
  late String Address;
  late String Amount_Collected;
  late String Amount_Remaining;
  late String Phone_No;
  String mode = 'cash';
  int installment = 0;
  int money = 0;
  String status = 'Paid';
  late String Amount;
  late String CIF_No;
  late String dropdownvalue;
  String placedropdownvalue = 'Basant Road';
  final _firestone = FirebaseFirestore.instance;
  bool selA = false;
  bool selB = true;
  late int monthly = 0;
  final _formKey = GlobalKey<FormState>();

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: 'Test eventeee',
      description: 'example',
      location: 'Flutter app',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(minutes: 30)),
      allDay: false,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 40),
        url: "http://example.com",
      ),
      androidParams: const AndroidParams(
        emailInvites: ["test@example.com"],
      ),
      recurrence: recurrence,
    );
  }

  DateTime date_open = DateTime.now();
  DateTime date_mature = DateTime(DateTime.now().year + 5, DateTime.now().month, DateTime.now().day);
  DateTime payment_date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    Size size = MediaQuery.of(context).size;
    if(widget.place == '5 Days'){
      dropdownvalue = '5 Days';
    }
    else if(widget.place == 'Monthly'){
      dropdownvalue = 'Monthly';
    }
    else{
      dropdownvalue = 'Daily';
    }
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: size.height * 0.36,
                decoration: const BoxDecoration(
                  color: Color(0xff757575),
                ),
              ),
              Container(
                // color: const Color(0xff757575),
                decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:_formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/Line 8.png',
                              ),
                              const Text(
                                'New Member',
                                style: TextStyle(
                                    color: Color(0xff205955),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: size.width * 0.09,
                              ),
                              Container(
                                height: size.height * 0.065,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                  child: Center(
                                    child: TextFormField(
                                      initialValue: '0',
                                      keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                        textAlign: TextAlign.left,
                                        onChanged: (value) {
                                          Amount = value;
                                        },
                                        validator: ((value) {
                                          if(value == null || value.isEmpty || int.parse(value) > 20000) {
                                            return 'Please enter correct value';
                                          }
                                          return null;
                                        }),
                                        decoration: const InputDecoration(
                                          // border: InputBorder.none,
                                          helperText: 'Monthly Amount',
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/pen.png',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: size.height * 0.065,
                                width: size.width * 0.5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Center(
                                    child: TextFormField(
                                        textCapitalization: TextCapitalization.words,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                        textAlign: TextAlign.left,
                                        onChanged: (value) {
                                          Member_Name = value;
                                        },
                                        validator: ((value) {
                                          if(value == null || value.isEmpty) {
                                            return 'Please enter some value';
                                          }
                                          return null;
                                        }),
                                        decoration: const InputDecoration(
                                            hintText: 'Member Name')),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.04,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.1,
                                  child: TextButton(
                                    onPressed: () {
                                      selA = true;
                                      selB = false;
                                      Plan = 'A';
                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: selA
                                          ? const MaterialStatePropertyAll<Color>(
                                              Color(0xff42A19A))
                                          : const MaterialStatePropertyAll<Color>(
                                              Color(0xffD9D9D9)),
                                    ),
                                    child: const Text(
                                      'A',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.1,
                                  child: TextButton(
                                    onPressed: () {
                                      selA = false;
                                      selB = true;
                                      Plan = 'B';
                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: selB
                                          ? const MaterialStatePropertyAll<Color>(
                                              Color(0xff42A19A))
                                          : const MaterialStatePropertyAll<Color>(
                                              Color(0xffD9D9D9)),
                                    ),
                                    child: const Text(
                                      'B',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/pen.png',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: size.height * 0.065,
                                width: size.width * 0.5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Center(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                        textAlign: TextAlign.left,
                                        onChanged: (value) {
                                          Account_No = value;
                                        },
                                        validator: ((value) {
                                          if(value == null || value.isEmpty || value.length < 10) {
                                            return 'Please enter correct value';
                                          }
                                          return null;
                                        }),
                                        decoration: const InputDecoration(
                                            hintText: 'Account No')),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(size.width * 0.04 ),
                              child: Text(dropdownvalue, style: const TextStyle(fontSize: 20),),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/pen.png',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: size.height * 0.065,
                                width: size.width * 0.7,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Center(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                        textAlign: TextAlign.left,
                                        onChanged: (value) {
                                          CIF_No = value;
                                        },
                                        validator: ((value) {
                                          if(value == null || value.isEmpty) {
                                            return 'Please enter some value';
                                          }
                                          return null;
                                        }),
                                        decoration:
                                            const InputDecoration(hintText: 'CIF No')),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_month_rounded),
                                  Container(
                                    height: size.height * 0.045,
                                    width: size.width * 0.34,
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
                                              DateTime? newDateOpen =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: date_open,
                                                      firstDate: DateTime(1990),
                                                      lastDate: DateTime(2100));
                                              if (newDateOpen == null) return;
                
                                              setState(() => date_open = newDateOpen);
                                              setState(() => date_mature = DateTime(
                                                  date_open.year + 5,
                                                  date_open.month,
                                                  date_open.day));
                                            },
                                            child: Text(
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.left,
                                                '${date_open.day}/${date_open.month}/${date_open.year}')),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_month_rounded),
                                  Container(
                                    height: size.height * 0.045,
                                    width: size.width * 0.34,
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
                                              DateTime? newDateMature =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: date_mature,
                                                      firstDate: DateTime(1990),
                                                      lastDate: DateTime(2100));
                                              if (newDateMature == null) return;
                
                                              setState(() => date_mature = DateTime(
                                                  date_open.year + 5,
                                                  date_open.month,
                                                  date_open.day));
                                              
                                            },
                                            child: Text(
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.left,
                                                '${date_mature.day}/${date_mature.month}/${date_mature.year}')),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: size.height * 0.065,
                            width: size.width * 0.75,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Center(
                                child: TextFormField(
                                  initialValue: '0',
                                  keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      Amount_Collected = value;
                                    },
                                    validator: ((value) {
                                      if(value == null || value.isEmpty) {
                                        return 'Please enter some value';
                                      }
                                      return null;
                                    }),
                                    decoration: const InputDecoration(
                                        helperText: 'Amount Collected')),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: size.height * 0.065,
                            width: size.width * 0.75,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Center(
                                child: TextFormField(
                                  initialValue: '0',
                                  keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      Amount_Remaining = value;
                                    },
                                    validator: ((value) {
                                      if(value == null || value.isEmpty) {
                                        return 'Please enter some value';
                                      }
                                      return null;
                                    }),
                                    decoration: const InputDecoration(
                                        helperText: 'Balance',)),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 30,
                                  ),
                                  Container(
                                    height: size.height * 0.065,
                                    width: size.width * 0.75,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Center(
                                        child: TextFormField(
                                            style: const TextStyle(
                                              color: Colors.black87,
                                            ),
                                            textAlign: TextAlign.left,
                                            onChanged: (value) {
                                              Address = value;
                                            },
                                            validator: ((value) {
                                            if(value == null || value.isEmpty) {
                                              return 'Please enter the Address';
                                            }
                                            return null;
                                          }),
                                            decoration: const InputDecoration(
                                                hintText: 'Address')),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.call,
                                size: 30,
                              ),
                              Container(
                                height: size.height * 0.065,
                                width: size.width * 0.75,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Center(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                        textAlign: TextAlign.left,
                                        onChanged: (value) {
                                          Phone_No = value;
                                        },
                                        validator: ((value) {
                                          if(value == null || value.isEmpty || value.length != 10) {
                                            return 'Please enter correct value';
                                          }
                                          return null;
                                        }),
                                        decoration:
                                            const InputDecoration(hintText: 'Phone No')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 0.8,
                          color: Colors.black,
                        ),
                        TextButton(
                            onPressed: () {
                              // final dateo = DateTime.fromMillisecondsSinceEpoch(
                              //     date_open.millisecondsSinceEpoch);
                              // final yearo = dateo.year;
                              // final dayo = dateo.day;
                              // final datem = DateTime.fromMillisecondsSinceEpoch(
                              //     date_mature.millisecondsSinceEpoch);
                              // final yearm = datem.year;
                              // final daym = datem.day;
                              // int gap1 = 12 - dayo;
                              // int gap2 = 12 - daym;
                              // int gap3 = yearm - yearo;
                              // monthly = gap3 * 12;
                              // monthly = monthly - gap1 - gap2;
                              // monthly = (int.parse(Amount) / monthly).floor();
                              
                              if (_formKey.currentState!.validate()) {
                                int total_installment = 60;
                                int totalAmountCollected = int.parse(Amount_Collected)+int.parse(Amount_Remaining);
                                var next_due_date = DateTime(
                                                  date_open.year,
                                                  date_open.month + (int.parse(Amount_Collected)/int.parse(Amount)).floor() + 1,
                                                  date_open.day);
                                 
                                _firestone
                                    .collection(widget.place == '5 Days' || widget.place == 'Monthly' ? 'new_account' : 'new_account_d')
                                    .add(
                                    {
                                  'Member_Name': Member_Name,
                                  'Plan': Plan,
                                  'Account_No': Account_No,
                                  'Address': Address,
                                  'Amount_Collected': totalAmountCollected,
                                  'Amount_Remaining': int.parse(Amount_Remaining),
                                  'Phone_No': Phone_No,
                                  'Type': dropdownvalue,
                                  'Date_of_Maturity': date_mature,
                                  'Date_of_Opening': date_open,
                                  'CIF_No': CIF_No,
                                  'monthly': int.parse(Amount),
                                  'paid_installment': (int.parse(Amount_Collected)/int.parse(Amount)).floor(),
                                  'total_installment': total_installment,
                                  'status': status,
                                  'next_due_date' : next_due_date,
                                  'deposit_field': false,
                                  'place': widget.place == '5 Days' || widget.place == 'Monthly' ? '' : widget.place,
                                  'history' : {
                                    '${payment_date.year}-${payment_date.month < 10 ? '0${payment_date.month}' : payment_date.month}-${payment_date.day < 10 ? '0${payment_date.day}' : payment_date.day}' : {
                                      'payment_mode' : mode,
                                      'payment_amount' : totalAmountCollected,
                                    }
                                  }
                                });
                                // _firestone
                                //   .collection('summary')
                                //   .doc('${payment_date.year}-${payment_date.month < 10 ? '0${payment_date.month}' : payment_date.month}-${payment_date.day < 10 ? '0${payment_date.day}' : payment_date.day}')
                                //   .set(,SetOptions(merge: true));
                                _firestone
                                  .collection('records')
                                  .doc('${payment_date.year}-${payment_date.month < 10 ? '0${payment_date.month}' : payment_date.month}-${payment_date.day < 10 ? '0${payment_date.day}' : payment_date.day}')
                                  .set({Account_No : totalAmountCollected}, SetOptions(merge: true));

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Member Created')),
                                );
                                setState(() {
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Create Member',
                                style: TextStyle(
                                    color: Color(0xff205955),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
