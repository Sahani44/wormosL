import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship2/models/User_Tile/lapse_tile.dart';
import 'package:internship2/widgets/customnavbar.dart';

class lapse_screen extends StatefulWidget {
  static const id = '/lapse_master1';
  @override
  State<lapse_screen> createState() => _lapse_screenState();
}

class _lapse_screenState extends State<lapse_screen> {
  late int Count = 0;
  late int Amount = 0;
  final _firestone = FirebaseFirestore.instance;
  late String Name;
  int _currentIndex = 0;
  var _isloading = false;
  bool sel = true;
  bool notsel = true;
  final _inactiveColor = const Color(0xff71757A);
/*   void strm(String Name) {
    StreamBuilder(
        stream: _firestone
            .collection('new_account')
            .doc(Name)
            .collection(Name)
            .orderBy('Name')
            .snapshots(),
        builder: (context, snapshot) {
          final tiles = snapshot.data!.docs;
          Count = snapshot.data!.docs.length;
          for (var tile in tiles) {
            Amount += int.parse(tile.get('Amount_Remaining'));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Clients:$Count'),
              Text('Amount Collected:$Amount')
            ],
          );
        });
  } */

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
        child: Column(children: [
          SizedBox(
            height: size.height * 0.005,
          ),
          StreamBuilder(
              stream: _firestone
                  .collection('new_place')
                  .orderBy('Name')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final tiles = snapshot.data!.docs;
                List<Widget> Memberlist = [];
                for (var tile in tiles) {
                  Name = tile.get('Name');
                  Memberlist.add(lapse_title(Name));
                }
                return _isloading
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
                      );
              })
        ]),
      ),
    );
  }
}
