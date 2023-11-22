// ignore_for_file: non_constant_identifier_names, camel_case_types, no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship2/models/User_Tile/collection_tile.dart';
import 'package:internship2/widgets/customnavbar.dart';

class collection extends StatefulWidget {
  collection(this.screen, {super.key});
  static const id = '/collection';
  int screen = 1;
  @override
  State<collection> createState() => _collectionState(screen);
}

class _collectionState extends State<collection> {
  _collectionState(this.screen);
  int screen = 1;
  late int Count = 0;
  late int Amount = 0;
  final _firestone = FirebaseFirestore.instance;
  late String Name;
  // int _currentIndex = 0;
  var isloading = true;
  bool sel = true;
  bool notsel = true;
  Map data = {};
 List<Widget> Memberlist = [];

  // final _inactiveColor = const Color(0xff71757A);

  Future<bool> getDocs (Memberlist) async{
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestone.collection("new_account_d").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot1 = await _firestone.collection("new_place").get();
    var tiles1 = querySnapshot1.docs.toList();
    for(var tile in tiles1) {
      data.addAll({tile.get('Name'): {
        'clients' : 0,
        'amount' : 0,
        'balance' : 0
      }});
    }
    var tiles2 = querySnapshot.docs.toList();
    for(var tile in tiles2){
      var name = tile.get('place');
      int ac = tile.get('monthly');
      int ar = tile.get('Amount_Remaining');
      data.update(name, (value) => 
        {
          'clients': (value['clients']+1),
          'amount': (value['amount']+ac),
          'balance': (value['balance']+ar),
        
      });
    }
    for(var tile in tiles1){
      Memberlist.add(collection_tile(tile.get('Name'), screen, data[tile.get('Name')]));
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    getDocs(Memberlist).then((value) => setState(() {
      isloading = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomNavBar()),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff144743),
          ),
        ),
        title: const Text(
          'Place',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:  isloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        SizedBox(
                            height: size.height,
                            child: ListView.builder(
                              itemCount: Memberlist.length,
                              itemBuilder: (context, i) => Memberlist[i],
                            )),
                      ],
                    )
      ),
    );
  }
}

// final _firestone = FirebaseFirestore.instance;
// late String Name;
// int _currentIndex = 0;
// var _isloading = false;
// bool sel = true;
// bool notsel = true;
// final _inactiveColor = Color(0xff71757A);
// @override
// Widget build(BuildContext context) {
//   Size size = MediaQuery.of(context).size;
//   return Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const menu()),
//           );
//         },
//         icon: Icon(
//           Icons.arrow_back_ios_new_outlined,
//           color: Color(0xff144743),
//         ),
//       ),
//       title: Text(
//         ' Your Place',
//         style: TextStyle(
//           color: Colors.black54,
//         ),
//       ),
//     ),
//     body: SingleChildScrollView(
//       child: Column(children: [
//         SizedBox(
//           height: size.height * 0.005,
//         ),
//         StreamBuilder(
//             stream: _firestone
//                 .collection('new_place')
//                 .orderBy('Name')
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     backgroundColor: Colors.lightBlueAccent,
//                   ),
//                 );
//               }
//               final tiles = snapshot.data!.docs;
//               List<Widget> Memberlist = [];
//               for (var tile in tiles) {
//                 Name = tile.get('Name');
//                 Memberlist.add(place_tile(Name, '/collection2'));
//               }
//               return _isloading
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Column(
//                       children: [
//                         SizedBox(
//                             height: size.height,
//                             child: ListView.builder(
//                               itemCount: Memberlist.length,
//                               itemBuilder: (context, i) => Memberlist[i],
//                             )),
//                       ],
//                     );
//             })
//       ]),
//     ),
//     
//   );
// }
