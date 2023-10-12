import 'package:flutter/material.dart';
import 'package:internship2/Screens/Place/place_edit.dart';
import 'package:internship2/Screens/Place/usersearch.dart';

import '../../models/views/menu_tile.dart';

class NewMemberLanding extends StatelessWidget {
  const NewMemberLanding({super.key});

  static const id = '/new_member_landing';

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
                tle: 'Daily',
                logo: Image.asset('assets/collection/image134.png'),
                path:  const placeedit(),
              ),
              menu_tile(
                tle: '5 Days',
                logo: Image.asset('assets/collection/image134.png'),
                path: user('5 Days'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menu_tile(
                tle: 'Monthly',
                logo: Image.asset('assets/collection/image134.png'),
                path: user('Monthly'),
              ),
              // menu_tile(
              //   tle: 'Lapse '
              //       'Account',
              //   logo: Image.asset('assets/menu/lapse.png'),
              //   route: lapse_screen.id,
              // ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     menu_tile(
          //       tle: 'Maturity '
          //           'Update',
          //       logo: Image.asset('assets/menu/maturity.png'),
          //       route: mature_screen.id,
          //     ),
          //     menu_tile(
          //       tle: 'Rokar',
          //       logo: Image.asset('assets/menu/rokar.png'),
          //       route: '',
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}