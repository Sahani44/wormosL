// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Screens/Records/recorddata.dart';
import 'package:internship2/widgets/amountdata.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Row,Column,Border;
import '../../Providers/scheme_selector.dart';


class Record_Page extends StatefulWidget {
  static const id = '/Record_Page';
  const Record_Page({super.key});
  @override
  State<Record_Page> createState() => _Record_PageState();
}

class _Record_PageState extends State<Record_Page> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();

  String dropdownvalue = 'Monthly';
  var selectedValue = DateTime.now();
  late String Member_Name;
  late String Plan;
  late String Account_No;
  late Timestamp date_open;
  late Timestamp date_mature;
  late int monthly;
  bool _isloading = true;
  late String type;
  late int total_installment;
  late int Amount_Remaining;
  late int Amount_Collected;
  late Map<String, Map<String, dynamic>> history;
  late int paid_installment;
  late final _firestone = FirebaseFirestore.instance;
  final _inactiveColor = const Color(0xffEBEBEB);
  var tiles = [];
  var tiles1 = [];
  var dates = {};
  Map<String, dynamic>? ma = {};
  List<Widget> Memberlist = [];
  List<Widget> newMemberList = [];
  var totalClient = 0;
  var totalAmount = 0;
  var totalBalance = 0;
  late String add;
  late String phone;
  late String cif;
  late String place;
  int _currentIndex = 0;
  DateTime new_payment_date = DateTime.now();

  var m = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  var items = [
    'Weekly',
    'Monthly',
  ];

  DateTime dateTime1 = DateTime(1900);
  DateTime dateTime2 = DateTime(1900);

  void addData(List<Widget> Memberlist) {
    Memberlist.add(record_data(
        date_open: date_open,
        date_mature: date_mature,
        Account_No: Account_No,
        Member_Name: Member_Name,
        Plan: Plan,
        installment: paid_installment,
        status: 'paid',
        Location: place,
        Amount_Collected: Amount_Collected,
        Amount_Remaining: Amount_Remaining,
        Monthly: monthly,
        history: history,
        date: '${new_payment_date.year}-${new_payment_date.month < 10 ? '0${new_payment_date.month}' : new_payment_date.month}-${new_payment_date.day < 10 ? '0${new_payment_date.day}' : new_payment_date.day}',
      )
    );
  }

  Future<bool> getDocs(Memberlist) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestone.collection("new_account").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot1 =
        await _firestone.collection("new_account_d").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot2 =
        await _firestone.collection("records").get();
    tiles = querySnapshot.docs.toList() + querySnapshot1.docs.toList();
    tiles1 = querySnapshot2.docs.toList();

    for (var tile in tiles1) {
      dates.addAll({tile.id: tile.data()});
    }

    for (var tile in tiles) {
      Account_No = tile.get('Account_No').toString();
      Member_Name = tile.get('Member_Name');
      Plan = tile.get('Plan');
      phone = tile.get('Phone_No');
      cif = tile.get('CIF_No');
      add = tile.get('Address');
      place = tile.get('place');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      history = Map<String, Map<String, dynamic>>.from(tile.get('history'));
      type = tile.get('Type');
      monthly = tile.get('monthly');
      date_open = tile.get('Date_of_Opening');
      date_mature = tile.get('Date_of_Maturity');
      addData(Memberlist);
    }

    return false;
  }

  void getNewDocs() {
    Memberlist.clear();
    for (var tile in tiles) {
      Account_No = tile.get('Account_No').toString();
      Member_Name = tile.get('Member_Name');
      Plan = tile.get('Plan');
      phone = tile.get('Phone_No');
      cif = tile.get('CIF_No');
      add = tile.get('Address');
      place = tile.get('place');
      paid_installment = tile.get('paid_installment');
      total_installment = tile.get('total_installment');
      Amount_Remaining = tile.get('Amount_Remaining');
      Amount_Collected = tile.get('Amount_Collected');
      history = Map<String, Map<String, dynamic>>.from(tile.get('history'));
      type = tile.get('Type');
      monthly = tile.get('monthly');
      date_open = tile.get('Date_of_Opening');
      date_mature = tile.get('Date_of_Maturity');
      addData(Memberlist);
    }
  }

  @override
  void initState() {
    //set the initial value of text field
    super.initState();
    dateInput.text = "";
    new_payment_date = DateTime.now();
    getDocs(Memberlist).then((value) => setState(() {
          _isloading = value;
        }));
  }

  void getNewMemberList(int currentIndex) async {
    ma = dates['${new_payment_date.year}-${new_payment_date.month < 10 ? '0${new_payment_date.month}' : new_payment_date.month}-${new_payment_date.day < 10 ? '0${new_payment_date.day}' : new_payment_date.day}'];
    if (ma != null) {
      List accNo = ma!.keys.toList();
      for (int i = 0; i < tiles.length; i++) {
        if (accNo.contains(tiles[i].get('Account_No'))) {
          var plan = tiles[i].get('Plan');
          int ac = tiles[i].get('monthly');
          int ar = tiles[i].get('Amount_Remaining');
          String currentIndexAb = _currentIndex == 1 ? 'A' : _currentIndex == 2 ? 'B' : '';
          if (currentIndexAb == plan) {
            newMemberList.add(Memberlist[i]);
            totalClient += 1;
            totalAmount += ac;
            totalBalance += ar;
          }
          else if(currentIndexAb == ''){
            newMemberList.add(Memberlist[i]);
            totalClient += 1;
            totalAmount += ac;
            totalBalance += ar;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    newMemberList = [];
    totalClient = 0;
    totalAmount = 0;
    totalBalance = 0;
    if (dates.isNotEmpty) {getNewMemberList(_currentIndex);}
    return Scaffold(
      backgroundColor: Colors.white,
      /* appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          leading: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff144743),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              customized_date_picker(
                  title: "From Date", size: size, dateInput: dateInput),
              SizedBox(
                width: 4,
              ),
              customized_date_picker(
                  title: "To Date", size: size, dateInput: dateInput),
            ],
          ),
          actions: [
            IconButton(
                iconSize: 50,
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 30,
                ))
          ],
        ), */
      body: SafeArea(
        child: Column(
        children: [
        const SizedBox(height: 10,),
        Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month_rounded),
              Container(
                height: size.height * 0.045,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.black, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Center(
                    child: TextButton(
                        onPressed: () async {
                          DateTime? newPaymentDate = await showDatePicker(
                              context: context,
                              initialDate: new_payment_date,
                              firstDate: DateTime(1990),
                              lastDate: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day));
                          if (newPaymentDate == null) return;

                          setState(() {new_payment_date = newPaymentDate;
                           getNewDocs();});
                        },
                        child: Text(
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.left,
                            '${new_payment_date.day}-${m[new_payment_date.month - 1]}-${new_payment_date.year}')),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: size.height * 0.08,
              decoration: BoxDecoration(
                color: const Color(0XFFEBF0EF),
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
                border: Border.all(
                  width: 3,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: size.height * 0.055,
                      width: size.width * 0.4,
                      decoration: const BoxDecoration(
                        color: Color(0XFFFEFEFE),
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(
                            // Initial Value
                            value: dropdownvalue,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (var newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                        height: size.height * 0.055,
                        width: size.width * 0.4,
                        decoration: const BoxDecoration(
                          color: Color(0XFFFEFEFE),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        child: _buildAboveBar()),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: amountdata(totalClient, totalAmount, totalBalance, context),
          ),
          _isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SizedBox(
                        height: size.height * 0.64,
                        child: ListView.builder(
                          itemCount: newMemberList.length,
                          itemBuilder: (context, i) {
                            return newMemberList[i];
                          },
                        )),
                  ],
                ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff29756F),
            ),
            onPressed: () {
                    showModalBottomSheet<dynamic>(
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom);
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SingleChildScrollView(
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(children: [
                                        const SizedBox(height: 16.0),
                                        Image.asset(
                                          'assets/Line 8.png',
                                        ),
                                        const SizedBox(width: 16.0),
                                        const Text(
                                          'Select Duration',
                                          style: TextStyle(
                                              color: Color(0xff205955)),
                                        ),
                                      ]),
                                      const SizedBox(height: 16.0),
                                      // TextField(
                                      //     autofocus: true,
                                      //     style: const TextStyle(
                                      //       color: Colors.black87,
                                      //     ),
                                      //     textAlign: TextAlign.left,
                                      //     onChanged: (value) {
                                      //       setState(() {});
                                      //     },
                                      //     decoration: const InputDecoration(
                                      //         hintText: 'Place Name')),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                        width: size.width / 2.4,
                                        height: size.height * 0.067,
                                        /* decoration: BoxDecoration(
                                          color: Color(0XFFEBEBEB),
                                          borderRadius: BorderRadius.circular(18)), */
                                        child: Center(
                                          child: TextField(
                                            controller: dateInput,
                                            //editing controller of this TextField
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.calendar_today,
                                                  size: 10,
                                                ),
                                                labelText: "From Date",
                                                labelStyle: const TextStyle(fontSize: 13),
                                                hintText: dateInput.text,
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 3, color: Colors.grey), //<-- SEE HERE
                                                  borderRadius: BorderRadius.circular(50.0),
                                                )),
                                            readOnly: true,
                                            //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime.now());
                                              print(pickedDate);
                                              if (pickedDate != null) {
                                                print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd').format(pickedDate);

                                                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                setState(
                                                  () {
                                                    dateInput.text = formattedDate; //set output date to TextField value.
                                                    dateTime1 = pickedDate;
                                                  },
                                                );
                                              } else {}
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      SizedBox(
                                        width: size.width / 2.4,
                                        height: size.height * 0.067,
                                        /* decoration: BoxDecoration(
                                          color: Color(0XFFEBEBEB),
                                          borderRadius: BorderRadius.circular(18)), */
                                        child: Center(
                                          child: TextField(
                                            controller: dateInput2,
                                            //editing controller of this TextField
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.calendar_today,
                                                  size: 20,
                                                ),
                                                labelText: "To Date",
                                                labelStyle: const TextStyle(fontSize: 13),
                                                hintText: "Hello",
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 3, color: Colors.grey), //<-- SEE HERE
                                                  borderRadius: BorderRadius.circular(50.0),
                                                )),
                                            readOnly: true,
                                            //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate2 = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime.now());
                                              print(pickedDate2);
                                              if (pickedDate2 != null) {
                                                print(pickedDate2); //pickedDate2 output format => 2021-03-10 00:00:00.000
                                                String formattedDate2 =
                                                    DateFormat('yyyy-MM-dd').format(pickedDate2);
                                                print( formattedDate2); //formatted date output using intl package =>  2021-03-16
                                                setState(
                                                  () {
                                                    dateInput2.text =
                                                        formattedDate2; //set output date to TextField value.
                                                    dateTime2 = pickedDate2;
                                                  },
                                                );
                                              } else {}
                                            },
                                          ),
                                        ),
                                      ),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff29756F), // Text color
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 8.0), // Button padding
                                        ),
                                        onPressed: () async {
                                            final Workbook workbook = Workbook();
                                            final Worksheet sheet = workbook.worksheets[0];
                                            var excelDataRows = dateFilter();
                                            sheet.importData(excelDataRows, 1, 1,);
                                            final List<int> bytes = workbook.saveAsStream();
                                            workbook.dispose();
                                            final String path = (await getApplicationSupportDirectory()).path;
                                            final String fileName = '$path/Record.xlsx';
                                            final File file = File(fileName);
                                            await file.writeAsBytes(bytes);
                                            OpenFile.open(fileName);
                                        },
                                        child: const Text(
                                          'Show',
                                          style: TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
            child: const Text("View Collection Sheet"),
          )
        ],
      )),
    );
  }

  List<ExcelDataRow> dateFilter() {
    List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
    if (dateInput.text != "" && dateInput2.text != "") {
      List<ExcelDataCell> cells = [];
      var records = {};
      
      cells.add((const ExcelDataCell(columnHeader: 'Acc. No.', value: '' )));
      dates.forEach((key, value) { cells.add(ExcelDataCell(columnHeader: key, value: ''));});
      excelDataRows.add(ExcelDataRow(cells: cells));

      dates.forEach((key, value) {
        value.forEach((key1, value1){
          records.update(
            key1, 
            (v) {
              v.addAll({
                key : value1 
              });
              return v;
            },
            ifAbsent:() => {key : value1},
          );
        });
       });

      records.forEach((key0, value0) {
        List<ExcelDataCell> cells = [];
        cells.add((ExcelDataCell(columnHeader: 'Acc. No.', value: key0)));
        dates.forEach((key1, _) {
          cells.add((ExcelDataCell(columnHeader: key1, value: value0['$key1'] ?? 0)));
        });
        excelDataRows.add(ExcelDataRow(cells: cells));
      });
      
    }
    return excelDataRows;
  }

  Widget _buildAboveBar() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedAboveBar(
      containerHeight: size.height * 0.055,
      containerWidth: size.width * 0.4,
      boxWidth: 40,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <AboveNavyBarItem>[
        AboveNavyBarItem(
          alpha: 'All',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: 'A',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
        AboveNavyBarItem(
          alpha: 'B',
          activeColor: Colors.grey,
          inactiveColor: _inactiveColor,
        ),
      ],
    );
  }
}

/*
SingleChildScrollView(
              child: StreamBuilder(
                  stream: _firestone
                      .collection('new_account')
                      .orderBy('Member_Name')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      );
                    }
                    final tiles = snapshot.data!.docs;
                    List<Widget> Memberlist = [];
                    for (var tile in tiles) {
                      Member_Name = tile.get('Member_Name');
                      Plan = tile.get('Plan');
                      Account_No = tile.get('Account_No').toString();
                      date_open = tile.get('Date_of_Opening');
                      date_mature = tile.get('Date_of_Maturity');
                      mode = tile.get('mode');
                      payment_dates = tile.get('payment_dates');
                      Type = tile.get('Type');
                      status = tile.get('status');
                      paid_installment = tile.get('paid_installment');
                      total_installment = tile.get('total_installment');
                      Amount_Remaining = tile.get('Amount_Remaining');
                      Amount_Collected = tile.get('Amount_Collected');
                      Monthly = tile.get('monthly');
                      DateTime openingDate =
                          DateTime.fromMicrosecondsSinceEpoch(
                              date_open.microsecondsSinceEpoch);

                      // from date != "" && to date != "", then
                      //if from date and to date is not empty, then
                      //check if openingDate >= from date && openingDate <= to date, then
                      //selectedDate >= from date && selectedDate <= to date, then
                      //add data

                      if (_currentIndex == 1) {
                        if (Plan == 'A') {
                          dateFilter(openingDate, Memberlist, size);
                        }
                      } else if (_currentIndex == 2) {
                        if (Plan == 'B') {
                          dateFilter(openingDate, Memberlist, size);
                        }
                      } else {
                        dateFilter(openingDate, Memberlist, size);
                      }
                    }
                    return _isloading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: SizedBox(
                              height: size.height * 0.61,
                              child: ListView.builder(
                                itemCount: Memberlist.length,
                                itemBuilder: (context, i) => Memberlist[i],
                              ),
                            ),
                          );
                  }),
            ),
*/
