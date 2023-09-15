// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

class user_tile extends StatefulWidget {
  final String Username;
  final int monthly;
  const user_tile(
    this.Username,
    this.monthly, {super.key}
  );
  @override
  State<user_tile> createState() => _user_tileState();
}

class _user_tileState extends State<user_tile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        selected: true,
        focusColor: const Color(0xff53927B),
        tileColor: Colors.white,
        selectedTileColor: const Color(0xff53927B),
        leading: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: size.height * 0.1,
          width: size.width * 0.14,
          child: Center(
            child: Text(
              widget.Username[0],
              style: const TextStyle(
                  color: Color(0xff29756F),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.expand_circle_down_rounded,
              color: Colors.white,
            )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          widget.Username,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          '${widget.monthly}/Month',
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
