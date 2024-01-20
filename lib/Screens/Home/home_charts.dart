// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Screens/Home/home_functions.dart';
import 'package:intl/intl.dart';

class HomeCharts extends StatefulWidget {
  HomeCharts({
    required this.date,
    super.key});
  static const id = '/homechart';
  late DateTime date;
  @override
  State<HomeCharts> createState() => _HomeChartsState();
}

class _HomeChartsState extends State<HomeCharts> {

  late final _firestone = FirebaseFirestore.instance;
  var tiles =[];
  var tiles1 = [];
  var x =[];
  List<FlSpot> dates = [];
  var maxY = 0;
  var _isloading = true;
  List<Widget> details = [];
  int catA = 0;
  int catB = 0;
  int overAll = 0;
  var items = {};
  var collected = 0;


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
    x = querySnapshot3.docs.toList();

    return false;
  
  }


  void createChart () {

    dates = [];
    details = [];
    collected = 0;
    catA = 0;catB = 0; overAll = 0;
    String d = DateFormat('yyyy-MM-dd').format(widget.date);
    if(!summaryDates.containsKey(d)){
      createSummary(d);
    }
    items.addAll(
      {
      'Monthly' : {
        'monthlyTotal' : 0,
        'monthlyReceived' : 0,
        'dailyReceived' : 0,
        'trans' : 0
      },
      '5 Days' : {
        'monthlyTotal' : 0,
        'monthlyReceived' : 0,
        'dailyReceived' : 0,
        'trans' : 0
      }}
    );

    for (var v in x) {
      items.addAll({
        v.get('Name') : {
          'monthlyTotal' : 0,
          'dailyTotal' : 0,
          'monthlyReceived' : 0,
          'dailyReceived' : 0,
          'trans' : 0
        }
      });
    }

    items.forEach((key, value) { 
      value['monthlyTotal'] = summaryDates[d]['monthlyTotal'][key] ;
      value['dailyTotal'] = (summaryDates[d]['monthlyTotal'][key]/30).floor();
    });

    

    for (var tile in tiles1) {

      if(widget.date.year == int.parse(tile.id.toString().substring(0,4)) && widget.date.month == int.parse(tile.id.toString().substring(5,7))){
        int received = 0;
        tile.data().forEach((key,value){
          if(widget.date.day >= int.parse(tile.id.toString().substring(8))){
            items[value['place']]['monthlyReceived'] += value['coll'] as int;
          }
          received += value['coll'] as int;
          if(tile.id == d){ 
            items[value['place']]['dailyReceived'] += value['coll'] as int;
            items[value['place']]['trans'] += 1;
            if(value['plan'] == 'A'){
              catA += value['coll'] as int;
            }
            else{
              catB += value['coll'] as int;
            }
            overAll += value['coll'] as int;
          }

        }); 
        collected += received;
        if(received > maxY) {
          maxY = received;
        }

        dates.add(FlSpot(double.parse(tile.id.toString().substring(8)), received.toDouble()));
      }
    }

    if(dates.isEmpty) {
      dates.add(const FlSpot(0, 0));
    }
    
    // String formatedDate = DateFormat('yyyy-MM-dd').format(widget.date);
    // for(var tile in tiles) {
    //   if(tile.get('history').keys.contains(formatedDate)) {
    //     if(tile.get('Plan') == 'A'){
    //       catA += tile.get('history')[formatedDate]['payment_amount'] as int;
    //     } else{
    //       catB += tile.get('history')[formatedDate]['payment_amount'] as int;
    //     }
    //     overAll += tile.get('history')[formatedDate]['payment_amount'] as int;
    //   }
    // }

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
    createChart();
    var itemsKeys = items.keys.toList();
    var itemsValues = items.values.toList();
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Text('Month Collection',style: TextStyle(color: Colors.white),),
                                Text('${summaryDates[DateFormat('yyyy-MM-dd').format(widget.date)]['totalAmount']}',style: const TextStyle(color: Colors.white),)
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Collected',style: TextStyle(color: Colors.white),),
                                Text('$collected',style: const TextStyle(color: Colors.white),)
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 33 * 25,
                    height: size.height * .35,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineChart(
                          LineChartData(
                            minX: 1,
                            maxX: 31,
                            minY: 0,
                            maxY: maxY.toDouble(),
                            lineBarsData: [
                              LineChartBarData(
                                spots: dates,
                                isCurved: false,
                                color: Colors.blue,
                                dotData: const FlDotData(show: true)
                              ),
                            ],
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  getTitlesWidget: bottomTitleWidgets,
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  getTitlesWidget: leftTitleWidgets,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: const Color(0xff37434d)),
                            ),
                            gridData: const FlGridData(show: false),
                          )
                        ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${widget.date.day}/${widget.date.month}/${widget.date.year}'s Collection",style: const TextStyle(color: Colors.white)),
                          Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Overall',style: TextStyle(color: Colors.white)),
                              Text('$overAll',style: const TextStyle(color: Colors.white))
                            ],
                          ),
                          Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Category A',style: TextStyle(color: Colors.white)),
                              Text('$catA',style: const TextStyle(color: Colors.white))
                            ],
                          ),
                          Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Category B',style: TextStyle(color: Colors.white)),
                              Text('$catB',style: const TextStyle(color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    )
                  )
                )
              ),              
              const Padding(
                padding: EdgeInsets.all(8.0),
                child:  Text('Details',style: TextStyle(color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                          onPressed: () async {
                DateTime? newDateOpen =
                    await showDatePicker(
                        context: context,
                        initialDate: widget.date,
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now());
                if (newDateOpen == null) return;
              
                setState(() => widget.date = newDateOpen);
                          },
                          child: Text(
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                  '${widget.date.day}/${widget.date.month}/${widget.date.year}')
                          ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: itemsKeys.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i) {
                    return createRow(itemsKeys[i], itemsValues[i]['trans'], itemsValues[i]['dailyTotal'], itemsValues[i]['dailyReceived'], itemsValues[i]['monthlyTotal'], itemsValues[i]['monthlyReceived']);
                  }
                ),
              )
              // createRow(itemsKeys[0], itemsValues[0]['trans'], itemsValues[0]['received'], itemsValues[0]['total'])
            ],
          ),
        ),
      ),
    );
  }

  Widget createRow(String roadName, int trans,int dailyTotal, int dailyReceived, int monthlyTotal, int monthlyReceived) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 40,
        child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(roadName ,style: const TextStyle(color: Colors.black)),
                        Text('$trans',style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('$dailyTotal',style: const TextStyle(color: Colors.black)),
                        Text('$dailyReceived',style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('$monthlyTotal',style: const TextStyle(color: Colors.black)),
                        Text('$monthlyReceived',style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

}