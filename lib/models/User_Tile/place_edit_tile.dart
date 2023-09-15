// ignore_for_file: non_constant_identifier_names, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:internship2/Screens/Place/usersearch.dart';

class place_edit_tile extends StatelessWidget {
  place_edit_tile(this.Name, {super.key});
  late String Name;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.009,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2,right: 2),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => user(Name)),
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
          ),
        ),
      ],
    );
  }
}
