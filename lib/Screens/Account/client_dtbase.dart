// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Screens/Menu.dart';

class Client_dbt extends StatelessWidget {
  final String acc;
  final String memberName;
  final String cif;
  final Timestamp doo;
  final Timestamp dom;
  final String location;
  final int amtcltd;
  final int amtrmn;
  final String add;
  final int monthly;
  final String phone;
  final String plan;

  const Client_dbt({
    Key? key,
    required this.memberName,
    required this.acc,
    required this.cif,
    required this.doo,
    required this.dom,
    required this.location,
    required this.amtcltd,
    required this.amtrmn,
    required this.add,
    required this.monthly,
    required this.phone, 
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.all(30.0),
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
                          memberName[0],
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
                          memberName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 25.0,
                          ),
                        ),
                        Text(
                          location,
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
                      Text(
                        acc,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff545454),
                          fontWeight: FontWeight.w500,
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
                    width: size.width * 0.28,
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                    child: TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff42A19A))),
                      child: Text(
                        plan,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
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
                      Text(
                        cif,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff545454),
                          fontWeight: FontWeight.w500,
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
                          Text(
                            '${doo.toDate().day}/${doo.toDate().month}/${doo.toDate().year}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff545454),
                              fontWeight: FontWeight.w500,
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
                    width: size.width * 0.08,
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
                          Text(
                            '${dom.toDate().day}/${dom.toDate().month}/${dom.toDate().year}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff545454),
                              fontWeight: FontWeight.w500,
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
                          Text(
                            amtcltd.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff545454),
                              fontWeight: FontWeight.w500,
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
                    width: size.width * 0.08,
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
                          Text(
                            amtrmn.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff545454),
                              fontWeight: FontWeight.w500,
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
                    Text(
                      monthly.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff545454),
                        fontWeight: FontWeight.w500,
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
              SizedBox(
                height: size.height * 0.06,
                child: Row(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          add,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color(0xff545454),
                            fontWeight: FontWeight.w500,
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
                      Text(
                        phone,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff545454),
                          fontWeight: FontWeight.w500,
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
            ],
          ),
        ));
  }
}
