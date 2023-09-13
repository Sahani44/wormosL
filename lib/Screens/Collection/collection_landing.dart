import 'package:flutter/material.dart';
import 'package:internship2/Screens/Collection/collection.dart';
import 'package:internship2/Screens/Collection/collection2.dart';
import 'package:internship2/models/views/menu_tile.dart';

class CollectionLanding extends StatelessWidget {
  const CollectionLanding({Key? key}) : super(key: key);
  static const id = '/collection_landing';

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
                path:  collection(1),
              ),
              menu_tile(
                tle: '5 Days',
                logo: Image.asset('assets/collection/image134.png'),
                path: collection2('5 Days'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menu_tile(
                tle: 'Monthly',
                logo: Image.asset('assets/collection/image134.png'),
                path: collection2('Monthly'),
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