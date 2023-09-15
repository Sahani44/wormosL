// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:internship2/Screens/Place/newmember.dart';
import 'package:internship2/models/User_Tile/user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class user extends StatefulWidget {
  user(
    this.Place, {super.key}
  );
  String Place;
  static const id = '/user';
  @override
  State<user> createState() => _userState(Place);
}

class _userState extends State<user> {
  _userState(
    this.Place,
  );
  String Place;
  late String Username;
  late String startdate;
  late String enddate;
  late String amt;
  late int monthly;
  final _firestone = FirebaseFirestore.instance;
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Container(
          width: double.infinity,
          height: size.height * 0.05,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(18)),
          child: const Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.005,
          ),
          StreamBuilder(
              stream: _firestone
                  .collection('new_account_d')
                  .where('place', isEqualTo: Place)
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
                  Username = tile.get('Member_Name');
                  monthly = tile.get('monthly');
                  Memberlist.add(user_tile(Username, monthly));
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
      floatingActionButton: SizedBox(
        width: size.width * 0.45,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => newmem(place: Place,)),
            );
          },
          backgroundColor: const Color(0xffA0205E),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: const Text(
            'Add Member',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
