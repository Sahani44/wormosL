import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeCharts extends StatefulWidget {
  HomeCharts({
    required String date,
    super.key});
  static const id = '/homechart';
  late String date;
  @override
  State<HomeCharts> createState() => _HomeChartsState();
}

class _HomeChartsState extends State<HomeCharts> {

  late final _firestone = FirebaseFirestore.instance;
  var tiles =[];
  var tiles1 = [];
  List<FlSpot> dates = [];
  var _isloading = true;
  var items = [    
    'Monthly',
    '5 Days',
  ];


  Future<bool> getDocs () async {

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestone.collection("new_account").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot1 =
        await _firestone.collection("new_account_d").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot2 =
        await _firestone.collection("records").get();
    QuerySnapshot<Map<String, dynamic>> querySnapshot3 =
        await _firestone.collection("new_place").get();
    tiles = querySnapshot.docs.toList() + querySnapshot1.docs.toList();
    tiles1 = querySnapshot2.docs.toList();
    var x = querySnapshot3.docs.toList();
    
    for (var v in x) {
      items.add(v.get('Name'));
    }

    for (var tile in tiles1) {
      dates.add(FlSpot(tile.id.toString().substring(8) as double,tile.data()['total'] as double));
    }
    return false;
  
  }

    @override
    void initState() {
    super.initState();
    getDocs().then((value) => setState(() {
      _isloading = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
     Scaffold(
      body: _isloading
    ? const Center(
        child: CircularProgressIndicator(),
      )
    : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 50, 148, 141)
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text('Month Collection',style: TextStyle(color: Colors.white),),
                                Text('10000000',style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Column(
                              children: [
                                Text('Month Collection',style: TextStyle(color: Colors.white),),
                                Text('10000000',style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Container(
                    height: size.height * 0.25,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 50, 148, 141)
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Today's Collection",style: TextStyle(color: Colors.white)),
                          Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Overall',style: TextStyle(color: Colors.white)),
                              Text('50000',style: TextStyle(color: Colors.white))
                            ],
                          ),
                          Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Category A',style: TextStyle(color: Colors.white)),
                              Text('50000',style: TextStyle(color: Colors.white))
                            ],
                          ),
                          Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Category B',style: TextStyle(color: Colors.white)),
                              Text('50000',style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    )
                  )
                )
              ),
              Expanded(
                child: AspectRatio(aspectRatio: 1.5,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: dates,
                        isCurved: true,
                        color: Colors.blue,
                        dotData: const FlDotData(show: false)
                      ),
                    ],
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                  )
                ),
              )),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child:  Text('Details',style: TextStyle(color: Colors.black)),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget createRow(String roadName, String trans, String received, String total) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(roadName ,style: const TextStyle(color: Colors.black)),
                  Text(trans,style: const TextStyle(color: Colors.black)),
                ],
              ),
              Column(
                children: [
                  Text(received,style: const TextStyle(color: Colors.black)),
                  Text(total,style: const TextStyle(color: Colors.black)),
                ],
              )
            ],
          );
  }

}