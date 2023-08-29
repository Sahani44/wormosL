// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:internship2/Screens/Collection/collection2.dart';
import 'package:internship2/Screens/Account/Account_Master.dart';

class collection_tile extends StatelessWidget {
  late int Count = 0;
  late int Amount = 0;
  // final _firestone = FirebaseFirestore.instance;
  collection_tile(this.Name, this.screen, {super.key});
  late String Name;
  int screen = 1;
  late Widget path;
  @override
  Widget build(BuildContext context) {
    if (screen == 0) {
      path = acc_master(Name);
    } else if (screen == 1) {
      path = collection2(Name);
    }
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.009,
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => path),
            );
          },
          selected: false,
          focusColor: const Color(0xffA9C8C5),
          tileColor: Colors.white,
          selectedTileColor: const Color(0xffA9C8C5),
          leading: Image.asset('assets/place_edit/h3.png'),
          title: Text(
            Name,
            style: const TextStyle(
            color: Colors.black,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Clients:$Count'),
              Text('Amount Collected:$Amount')
            ],
          )
        ),
      ],
    );
  }
}
