// ignore_for_file: non_constant_identifier_names, no_logic_in_create_state

import 'package:flutter/material.dart';

class place_tile extends StatefulWidget {
  place_tile(this.Name, this.Count, this.Amount, this.Location, {super.key});
  String Name;
  int Count;
  int Amount;
  String Location;
  @override
  State<place_tile> createState() =>
      _place_tileState(Name, Count, Amount, Location);
}

class _place_tileState extends State<place_tile> {
  _place_tileState(this.Name, this.Count, this.Amount, this.Location);
  // bool selected = false;
  late String Name;
  int Count;
  int Amount;
  String Location = '';
  bool sel = true;
  bool notsel = true;
  final _inactiveColor = const Color(0xff71757A);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      SizedBox(
        height: size.height * 0.005,
      ),
      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: () {
            if (sel == true) {
              sel = false;
              setState(() {});
            } else {
              sel == true;
              setState(() {});
            }
            // Navigator.of(context).pushNamed(Location);(commented by dev)
          },
          selected: false,
          focusColor: const Color(0xffA9C8C5),
          tileColor: Colors.white,
          selectedTileColor: const Color(0xffA9C8C5),
          leading: Image.asset('assets/house-line-fill 1.png'),
          trailing: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Clients:$Count'),
              // Text('Amount Collected:$Amount')
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text(
              Name,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
