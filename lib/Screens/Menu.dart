import 'package:flutter/material.dart';
import 'package:internship2/Screens/Account/acc_screen.dart';
import 'package:internship2/Screens/Due/due_screen.dart';
import 'package:internship2/Screens/Lapse/lapsescreen.dart';
import 'package:internship2/Screens/Maturity/mature_screen.dart';
import 'package:internship2/Screens/Records/location.dart';
import 'package:internship2/models/views/menu_tile.dart';
import 'package:internship2/widgets/customnavbar.dart';

class menu extends StatelessWidget {
  const menu({Key? key}) : super(key: key);
  static const id = '/menu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menu_tile(
                tle: 'Account '
                    'Master',
                logo: Image.asset('assets/menu/acc_master.png'),
                path: acc_screen(0),
              ),
              menu_tile(
                tle: 'Due '
                    'Account',
                logo: Image.asset('assets/menu/due_acc.png'),
                path: due_screen(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menu_tile(
                tle: 'Records ',
                logo: Image.asset('assets/menu/records.png'),
                path: record_screen(),
              ),
              menu_tile(
                tle: 'Lapse '
                    'Account',
                logo: Image.asset('assets/menu/lapse.png'),
                path: lapse_screen(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menu_tile(
                tle: 'Maturity '
                    'Update',
                logo: Image.asset('assets/menu/maturity.png'),
                path: mature_screen(),
              ),
              menu_tile(
                tle: 'Rokar',
                logo: Image.asset('assets/menu/rokar.png'),
                path: const CustomNavBar(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
