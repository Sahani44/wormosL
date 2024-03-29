import 'package:flutter/material.dart';
import 'package:internship2/Screens/Collection/collection2.dart';
import 'package:internship2/Screens/Place/usersearch.dart';
import 'package:internship2/Screens/Maturity/maturity.dart';

class mature_tile extends StatelessWidget {
  mature_tile(this.Name);
  late String Name;
  late Widget path;
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
              MaterialPageRoute(builder: (context) => maturity()),
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
