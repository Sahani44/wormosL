// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Screens/Menu.dart';

import '../Home/home_functions.dart';

class Client_dbt extends StatefulWidget {
  late String acc;
  late String memberName;
  late String cif;
  late Timestamp doo;
  late Timestamp dom;
  late Timestamp ndd;
  late String location;
  late int amtcltd;
  late int amtrmn;
  late String add;
  late int monthly;
  late String phone;
  late String plan;
  late var id;
  late String accType;
  var callback;


  Client_dbt({
    Key? key,
    required this.memberName,
    required this.acc,
    required this.cif,
    required this.doo,
    required this.dom,
    required this.location,
    required this.amtcltd,
    required this.amtrmn,
    required this.ndd,
    required this.add,
    required this.monthly,
    required this.phone, 
    required this.plan,
    required this.id,
    required this.accType,
    required this.callback,
  }) : super(key: key);

  @override
  State<Client_dbt> createState() => _Client_dbtState();
}

class _Client_dbtState extends State<Client_dbt> {
  
  final _formKey = GlobalKey<FormState>();
  final _firestone = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    var oldPlan = widget.plan;
    var oldBal = widget.amtrmn;
    var oldmonthly = widget.monthly;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const menu()),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xff144743),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key:_formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.099,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffA5C5C3),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          height: size.height * 0.080,
                          width: size.width * 0.16,
                          child: Center(
                            child: Text(
                              widget.memberName[0],
                              style: const TextStyle(
                                  color: Color(0xff29756F),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.memberName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                              widget.location,
                              style: const TextStyle(
                                color: Color(0xff205955),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  SizedBox(
                    height: size.height * 0.013,
                  ),
                  Row(
                    children: [
                      Image.asset('assets/Acc/image 27.png'),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.065,
                            width: size.width * 0.34,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                            ),
                            child: TextFormField(
                              initialValue: widget.acc,
                              keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.left,
                                onChanged: (value) {
                                  widget.acc = value;
                                },
                                validator: ((value) {
                                  if(value == null || value.isEmpty || value.length < 10) {
                                    return 'Please enter correct value';
                                  }
                                  return null;
                                }
                              ),
                              // decoration: InputDecoration(
                              //   hintText: widget.acc,
                              //   hintStyle:const TextStyle(
                              //     fontSize: 18,
                              //     color: Color(0xff545454),
                              //     fontWeight: FontWeight.w500,
                              //   )
                              // )
                            ),
                          ),
                          const Text(
                            'Account No',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xff205955),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.1,
                            child: TextButton(
                              onPressed: () {
                                widget.plan = 'A';
                                setState(() {});
                              },
                              style: ButtonStyle(
                                backgroundColor: widget.plan == 'A'
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
                                widget.plan = 'B';
                                setState(() {});
                              },
                              style: ButtonStyle(
                                backgroundColor: widget.plan == 'B'
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
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Image.asset('assets/image 35.png'),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.065,
                            width: size.width * 0.34,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                            ),
                            child: TextFormField(
                              initialValue: widget.cif,
                              keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.left,
                                onChanged: (value) {
                                  widget.cif = value;
                                },
                                validator: ((value) {
                                  if(value == null || value.isEmpty ) {
                                    return 'Please enter correct value';
                                  }
                                  return null;
                                }),
                              // decoration: InputDecoration(
                              //   hintText: widget.cif,
                              //   hintStyle:const TextStyle(
                              //     fontSize: 18,
                              //     color: Color(0xff545454),
                              //     fontWeight: FontWeight.w500,
                              //   )
                              // )
                            ),
                          ),
                          const Text(
                            'CIF No',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xff205955),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: size.height * 0.013,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/Acc/calendar.png'),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  DateTime? newDateOpen =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: widget.doo.toDate(),
                                          firstDate: DateTime(1990),
                                          lastDate: DateTime(2100));
                                  if (newDateOpen == null) return;
    
                                  setState(() {
                                    widget.doo = Timestamp.fromDate(newDateOpen);
                                  });
                                },
                                child: Text(
                                '${widget.doo.toDate().day}/${widget.doo.toDate().month}/${widget.doo.toDate().year}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff545454),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ),
                              const Text(
                                'Date of Opening',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xff205955),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/Acc/calendar.png'),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              TextButton(
                                onPressed: () async {
                                  DateTime? newDateMature =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: widget.dom.toDate(),
                                          firstDate: DateTime(1990),
                                          lastDate: DateTime(2100));
                                  if (newDateMature == null) return;
    
                                  setState(() {
                                    widget.dom = Timestamp.fromDate(DateTime(
                                      newDateMature.year,
                                      newDateMature.month,
                                      newDateMature.day));
                                    widget.ndd = Timestamp.fromDate(DateTime(
                                      widget.ndd.toDate().year,
                                      widget.ndd.toDate().month,
                                      newDateMature.day));
                                  });
                                },
                                child: Text(
                                '${widget.dom.toDate().day}/${widget.dom.toDate().month}/${widget.dom.toDate().year}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff545454),
                                  fontWeight: FontWeight.w500,
                                ),
                                ),
                              ),
                              const Text(
                                'Date of Maturity',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xff205955),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: size.height * 0.013,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width * 0.05,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.07,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                          height: size.height * 0.065,
                          width: size.width * 0.25,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                          ),
                          child: TextFormField(
                            initialValue: widget.amtcltd.toString(),
                            keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.left,
                              onChanged: (value) {
                                widget.amtcltd = int.parse(value);
                              },
                              validator: ((value) {
                                if(value == null || value.isEmpty) {
                                  return 'Please enter correct value';
                                }
                                return null;
                              }),
                            // decoration: InputDecoration(
                            //   hintText: widget.amtcltd.toString(),
                            //   hintStyle:const TextStyle(
                            //     fontSize: 18,
                            //     color: Color(0xff545454),
                            //     fontWeight: FontWeight.w500,
                            //   )
                            // )
                          ),
                        ),
                              const Text(
                                'Amount Collected',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  color: Color(0xff205955),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width * 0.05,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.07,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                          height: size.height * 0.065,
                          width: size.width * 0.2,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                          ),
                          child: TextFormField(
                            initialValue: widget.amtrmn.toString(),
                            keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.left,
                              onChanged: (value) {
                                widget.amtrmn = int.parse(value);
                              },
                              validator: ((value) {
                                if(value == null || value.isEmpty) {
                                  return 'Please enter correct value';
                                }
                                return null;
                              }),
                            // decoration: InputDecoration(
                            //   hintText: widget.amtrmn.toString(),
                            //   hintStyle:const TextStyle(
                            //     fontSize: 18,
                            //     color: Color(0xff545454),
                            //     fontWeight: FontWeight.w500,
                            //   )
                            // )
                          ),
                        ),
                              const Text(
                                'Amount Remaining',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  color: Color(0xff205955),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                    child: Row(
                      children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.07,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Container(
                          height: size.height * 0.050,
                          width: size.width * 0.2,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                          ),
                          child: TextFormField(
                            initialValue: widget.monthly.toString(),
                            keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.left,
                              onChanged: (value) {
                                widget.monthly = int.parse(value);
                              },
                              validator: ((value) {
                                if(value == null || value.isEmpty) {
                                  return 'Please enter correct value';
                                }
                                return null;
                              }),
                            // decoration: InputDecoration(
                            //   hintText: widget.amtrmn.toString(),
                            //   hintStyle:const TextStyle(
                            //     fontSize: 18,
                            //     color: Color(0xff545454),
                            //     fontWeight: FontWeight.w500,
                            //   )
                            // )
                          ),
                        ),
                        const Text(
                          'Monthly',
                          style: TextStyle(
                            fontSize: 9.5,
                            color: Color(0xff205955),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],)
                    ]),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.07,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.065,
                            width: size.width * 0.34,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                            ),
                            child: TextFormField(
                              initialValue: widget.add,
                              keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.left,
                                onChanged: (value) {
                                  widget.add = value;
                                },
                                validator: ((value) {
                                  if(value == null || value.isEmpty ) {
                                    return 'Please enter correct value';
                                  }
                                  return null;
                                }),
                              // decoration: InputDecoration(
                              //   hintText: widget.add,
                              //   hintStyle:const TextStyle(
                              //     fontSize: 18,
                              //     color: Color(0xff545454),
                              //     fontWeight: FontWeight.w500,
                              //   )
                              // )
                            ),
                          ),
                          const Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Color(0xff205955),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/Acc/call.png'),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.065,
                            width: size.width * 0.34,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                            ),
                            child: TextFormField(
                              initialValue: widget.phone,
                              keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.left,
                                onChanged: (value) {
                                  widget.phone = value;
                                },
                                validator: ((value) {
                                  if(value == null || value.isEmpty || value.length < 10) {
                                    return 'Please enter correct value';
                                  }
                                  return null;
                                }),
                              // decoration: InputDecoration(
                              //   hintText: widget.phone,
                              //   hintStyle:const TextStyle(
                              //     fontSize: 18,
                              //     color: Color(0xff545454),
                              //     fontWeight: FontWeight.w500,
                              //   )
                              // )
                            ),
                          ),
                          const Text(
                            'Phone No',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xff205955),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: size.height * 0.02,),
                  FloatingActionButton.extended(
                    label: const Text('Done'),
                    backgroundColor: const Color(0xff42A19A),
                    onPressed: () => {
                      if (_formKey.currentState!.validate()) {
                        if(oldmonthly != widget.monthly){
                          updateSummary('${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}', 9, widget.monthly-oldmonthly, plan: widget.plan)
                        },
                        if(oldBal != widget.amtrmn){
                          updateSummary('${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}',6,widget.amtrmn-oldBal)
                        },
                        _firestone
                        .collection(widget.accType == 'Daily' ? 'new_account_d' : 'new_account')
                        .doc(widget.id)
                        .set({
                          'Account_No' : widget.acc,
                          'CIF_No' : widget.cif,
                          'Amount_Collected' : widget.amtcltd,
                          'Amount_Remaining' : widget.amtrmn,
                          'Address' : widget.add,
                          'Phone_No' : widget.phone,
                          'monthly' : widget.monthly,
                          'Plan' : widget.plan,
                          'Date_of_Opening' : widget.doo,
                          'Date_of_Maturity' : widget.dom,
                          'next_due_date' : widget.ndd,
                          'paid_installment' : ((widget.amtcltd+widget.amtrmn)/widget.monthly).floor()
                        },SetOptions(merge: true)),
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Details Updated')),
                        )
                      },
                      if(widget.callback !=''){
                        widget.callback()
                      }
                    }
                  )
                ],
              ),
            ),
          ),
        )
      );
  }
}
