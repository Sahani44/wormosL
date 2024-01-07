// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship2/Screens/Home/home_functions.dart';
import 'package:internship2/Screens/Place/newmember.dart';
import 'package:internship2/models/User_Tile/place_edit_tile.dart';
import 'package:internship2/widgets/customnavbar.dart';
import 'package:intl/intl.dart';

class placeedit extends StatefulWidget {
  const placeedit({Key? key}) : super(key: key);
  static const id1 = '/placeedit';
  @override
  State<placeedit> createState() => _placeeditState();
}

class _placeeditState extends State<placeedit> {
  late String place_name;
  late String place_posted;
  var _isloading = false;
  final _firestone = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaqueryData = MediaQuery.of(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: mediaqueryData.viewInsets,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomNavBar()),
            );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xff144743),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Place',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              IconButton(
                  iconSize: 50,
                  onPressed: () {
                    showModalBottomSheet<dynamic>(
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
                                color: const Color(0xffBBF5F1),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(children: [
                                        const SizedBox(height: 16.0),
                                        Image.asset(
                                          'assets/Line 8.png',
                                        ),
                                        const SizedBox(width: 16.0),
                                        const Text(
                                          'New Place',
                                          style: TextStyle(
                                              color: Color(0xff205955)),
                                        ),
                                      ]),
                                      const SizedBox(height: 16.0),
                                      TextField(
                                          autofocus: true,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.left,
                                          onChanged: (value) {
                                            place_posted = value;
                                            setState(() {});
                                          },
                                          decoration: const InputDecoration(
                                              hintText: 'Place Name')),
                                      const SizedBox(height: 16.0),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              const Color(0xff29756F), // Text color
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 8.0), // Button padding
                                        ),
                                        onPressed: () {
                                          _firestone
                                              .collection('new_place')
                                              .add({
                                            'Name': place_posted,
                                          });
                                          addNewPlace(DateFormat('yyyy-MM-dd').format(DateTime.now()), place_posted);
                                          setState(() {
                                            Navigator.of(context).pop();
                                          });
                                          // Perform actions here
                                          // Close the bottom sheet
                                        },
                                        child: const Text(
                                          'Save',
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
                  // height: size.height * 0.09,
                  // width: size.width * 0.09,
                  icon: Image.asset('assets/app_pen.png'))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              height: size.height * 0.005,
            ),
            StreamBuilder(
                stream: _firestone
                    .collection('new_place')
                    .orderBy('Name')
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
                    place_name = tile.get('Name');
                    Memberlist.add(place_edit_tile(place_name));
                  }
                  return _isloading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            SizedBox(
                                height: size.height,
                                child: ListView.builder(
                                  itemCount: Memberlist.length,
                                  itemBuilder: (context, i) => Memberlist[i],
                                )),
                          ],
                        );
                })
          ]),
        ),
      ),
    );
  }
}
