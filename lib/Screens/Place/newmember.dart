// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  late int Amount_Collected;
  late int Amount_Remaining;
  late String Phone_No;
  String mode = 'cash';
  int installment = 0;
  int money = 0;
  String status = 'Paid';
  late int Amount;
  late String CIF_No;
  String dropdownvalue1 ='5 Days';
  String dropdownvalue2 = 'Daily';
  String placedropdownvalue = 'Basant Road';
  final _firestone = FirebaseFirestore.instance;
  bool selA = false;
  bool selB = true;
  late int monthly = 0;
  var items1 = ['5 Days' ,'Monthly'];
  var items2 = ['Daily'];

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
  DateTime date_mature = DateTime(
      DateTime.now().year + 5, DateTime.now().month, DateTime.now().day);
  DateTime payment_date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Size size = MediaQuery.of(context).size;
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
                color: const Color(0xff757575),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
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
                              height: size.height * 0.035,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(19.0, 10.0, 0.0, 0.0),
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.left,
                                      onChanged: (value) {
                                        Amount = int.parse(value);
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Monthly Amount',
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
                              height: size.height * 0.045,
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
                                  child: TextField(
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.left,
                                      onChanged: (value) {
                                        Member_Name = value;
                                      },
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
                              height: size.height * 0.045,
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
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.left,
                                      onChanged: (value) {
                                        Account_No = value;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Account No')),
                                ),
                              ),
                            ),
                          ),
                          widget.place == '' ?
                           DropdownButton(
                            value: dropdownvalue1,

                            icon: const Icon(Icons.keyboard_arrow_down),

                            items: items1.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue1 = newValue!;
                              });
                            },
                          )
                          :
                          DropdownButton(
                            value: dropdownvalue2,

                            icon: const Icon(Icons.keyboard_arrow_down),

                            items: items2.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue2 = newValue!;
                              });
                            },
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
                              height: size.height * 0.045,
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
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.left,
                                      onChanged: (value) {
                                        CIF_No = value;
                                      },
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
                                  width: size.width * 0.345,
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
                                  width: size.width * 0.345,
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
                          height: size.height * 0.05,
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {
                                    Amount_Collected = int.parse(value);
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Amount Collected')),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.height * 0.05,
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {
                                    Amount_Remaining = int.parse(value);
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Balance')),
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
                                  height: size.height * 0.05,
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
                                      child: TextField(
                                          style: const TextStyle(
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.left,
                                          onChanged: (value) {
                                            Address = value;
                                          },
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
                              height: size.height * 0.08,
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
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.left,
                                      onChanged: (value) {
                                        Phone_No = value;
                                      },
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
                            int total_installment = 60;
                            int totalAmountCollected = Amount_Collected+Amount_Remaining;
                            widget.place == '' 
                            ?  _firestone
                                .collection('new_account')
                                .doc(Account_No)
                                .set({
                              'Member_Name': Member_Name,
                              'Plan': Plan,
                              'Account_No': Account_No,
                              'Address': Address,
                              'Amount_Collected': totalAmountCollected,
                              'Amount_Remaining': Amount_Remaining,
                              'Phone_No': Phone_No,
                              'Type': dropdownvalue1,
                              'Date_of_Maturity': date_mature,
                              'Date_of_Opening': date_open,
                              'CIF_No': CIF_No,
                              'monthly': Amount,
                              'mode': mode,
                              'paid_installment': (Amount_Collected/Amount).floor(),
                              'total_installment': total_installment,
                              'status': status,
                              'deposit_field': true,
                              'payment_date': payment_date,
                            })
                            :  _firestone
                                .collection('new_account_d')
                                .doc(Account_No)
                                .set({
                              'Member_Name': Member_Name,
                              'Plan': Plan,
                              'Account_No': Account_No,
                              'Address': Address,
                              'Amount_Collected': totalAmountCollected,
                              'Amount_Remaining': Amount_Remaining,
                              'Phone_No': Phone_No,
                              'Type': dropdownvalue2,
                              'Date_of_Maturity': date_mature,
                              'Date_of_Opening': date_open,
                              'CIF_No': CIF_No,
                              'monthly': Amount,
                              'mode': mode,
                              'paid_installment': (Amount_Collected/Amount).floor(),
                              'total_installment': total_installment,
                              'status': status,
                              'deposit_field': true,
                              'payment_date': payment_date,
                              'place' : widget.place
                            });
                            setState(() {
                              Navigator.of(context).pop();
                            });
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
            ],
          ),
        ));
  }
}
