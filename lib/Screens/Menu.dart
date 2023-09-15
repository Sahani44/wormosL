// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:internship2/Screens/Account/Account_Master.dart';
import 'package:internship2/Screens/Deleted/deleted_landing.dart';
import 'package:internship2/Screens/Due/due.dart';
import 'package:internship2/Screens/Maturity/maturity.dart';
import 'package:internship2/Screens/Records/record_screen.dart';
import 'package:internship2/models/views/menu_tile.dart';
import 'package:internship2/widgets/customnavbar.dart';
import 'Lapse/lapse.dart';

class menu extends StatelessWidget {
  const menu({Key? key}) : super(key: key);
  static const id = '/menu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menu_tile(
                    tle: 'Account \nMaster',
                    logo: Image.asset('assets/menu/acc_master.png'),
                    path: acc_master(''),
                  ),
                  menu_tile(
                    tle: 'Due \nAccount',
                    logo: Image.asset('assets/menu/due_acc.png'),
                    path: const due(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menu_tile(
                    tle: 'Records ',
                    logo: Image.asset('assets/menu/records.png'),
                    path: const Record_Page(),
                  ),
                  menu_tile(
                    tle: 'Lapse \nAccount',
                    logo: Image.asset('assets/menu/lapse.png'),
                    path: const lapse(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menu_tile(
                    tle: 'Maturity \nUpdate',
                    logo: Image.asset('assets/menu/maturity.png'),
                    path: const maturity(),
                  ),
                  menu_tile(
                    tle: 'Rokar',
                    logo: Image.asset('assets/menu/rokar.png'),
                    path: const CustomNavBar(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menu_tile(
                    tle: 'Deleted \nAccount',
                    logo: Image.asset('assets/menu/image139.png'),
                    path: const deleted_landing(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
