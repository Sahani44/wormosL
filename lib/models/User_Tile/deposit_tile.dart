// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:internship2/Screens/deposit/deposit.dart';

class deposit_tile extends StatelessWidget {
  deposit_tile(this.Name, {super.key});
  late String Name;
  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(builder: (context) => const deposit()),
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
        ),
      ],
    );
  }
}
