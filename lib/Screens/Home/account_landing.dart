// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship2/Screens/Home/home.dart';
import 'package:internship2/Screens/Home/home_charts.dart';

import 'home_functions.dart';

class HomeLanding extends StatefulWidget {
  const HomeLanding({super.key});

  @override
  State<HomeLanding> createState() => _HomeLandingState();
}

class _HomeLandingState extends State<HomeLanding> {
  DateTime date = DateTime.now();
  bool _isloading = true;
  // late final _firestone = FirebaseFirestore.instance;
  var dates = {};

  // Future<bool> getDocs () async {
  //   QuerySnapshot<Map<String,dynamic>> querySnapshot = await _firestone.collection("summary").get();
  //   var tiles = querySnapshot.docs.toList();
  //   for (var tile in tiles) {
  //     dates.addAll({tile.id: tile.data()});
  //   }
  //   return false;
  // }

  // Home getNewData() {
  //   ma = dates['${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}'];
  //   Home a;
  //   if(ma!=null){
  //     a = Home.fromMap(ma!);
  //      print(a.toString());
  //   }
  //   else{
  //     a = Home(totalClient: 0, totalAmount: 0, clientA: 0, amountA: 0, clientB: 0, amountB: 0, A: {
  //   'totalAccount' : 0,
  //   'pending': {
  //     'remainingAccount' : 0,
  //     'totalAmount' : 0,
  //     'remainingAmount' : 0
  //   },
  //   'deposit': {
  //     'remainingAccount' : 0,
  //     'totalDeposited' : 0,
  //     'remainingDeposited' : 0
  //   }
  // }, B: {
  //   'totalAccount' : 0,
  //   'pending': {
  //     'remainingAccount' : 0,
  //     'totalAmount' : 0,
  //     'remainingAmount' : 0
  //   },
  //   'deposit': {
  //     'remainingAccount' : 0,
  //     'totalDeposited' : 0,
  //     'remainingDeposited' : 0
  //   }
  // }, totalBalance: 0, newAccount: 0, newAmount: 0, closedAmount: 0, closedAccount: 0);
  //   }
  //   return a;
  // return todaysData('${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}');
  // }

  @override
  void initState() {
    super.initState();
    getHomeDocs().then((value) => setState(() {
      _isloading = value;
    }));

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Home a = todaysData('${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(254, 252, 251, 251),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
            onPressed: () async {
              DateTime? newDateOpen =
                  await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now());
              if (newDateOpen == null) return;

              setState(() => date = newDateOpen);
            },
            child: Text(
                style: const TextStyle(
                  color: Colors.black87,
                ),
                textAlign: TextAlign.left,
                '${date.day}/${date.month}/${date.year}')
            ),
          ],
        ),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0, left: 12,right: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ACCOUNT SUMMARY'),
                        TextButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeCharts(date: '${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}')),
                          );
                        }, child: const Text('View Report'))
                      ],
                    ),
                    amountdataLoc(a.totalClient, a.totalAmount, 'All'),
                    amountdataLoc(a.clientA, a.amountA, 'A'),
                    amountdataLoc(a.clientB, a.amountB, 'B'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('1st HALF-A'),
                    const SizedBox(height: 20,),
                    const Text('Pending'),
                    amountdataLoc(a.A['pending']['account'], a.A['pending']['amount'], 'A',),
                    const SizedBox(height: 15,),
                    const Text('Deposited'),
                    amountdataLoc(a.A['deposit']['account'], a.A["deposit"]["amount"], 'A',),
                    const SizedBox(height: 20,),
                    const Text('2nd HALF-B'),
                    const SizedBox(height: 20,),
                    const Text('Pending'),
                    amountdataLoc(a.B['pending']['account'], a.B["pending"]["amount"], 'B'),
                    const SizedBox(height: 15,),
                    const Text('Deposited'),
                    amountdataLoc(a.B['deposit']['account'], a.B["deposit"]["amount"], 'B'),
                    const SizedBox(height: 20,),
                    const Text('Balance'),
                    Container(
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                      border: Border.all(
                        width: 3,
                        color: Colors.grey.shade300,
                        // style: BorderStyle.solid,
                      ),
                      color: Colors.grey[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text('Total\nBalance',style: TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
                        child: Container(
                          width: size.width*0.6,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            border: Border.all(
                              width: 8,
                              color: Colors.white
                            ),
                            color : Colors.white,
                          ),
                          child: Center(child: Text('${a.totalBalance}',style: const TextStyle(fontSize: 20),))
                        ),
                      ),
                    ]),),
                    const SizedBox(height: 20,),
                    const Text('2nd HALF-B'),
                    const SizedBox(height: 20,),
                    const Text('New & Closed Account'),
                    amountdataLoc2(a.newAccount, a.closedAccount, a.closedAmount, a.newAmount, 'New', 'Closed', 'Account', 'Amount'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget amountdataLoc(int totalClient, int totalAmount,String type) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        height: size.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
          border: Border.all(
            width: 3,
            color: Colors.grey.shade300,
            // style: BorderStyle.solid,
          ),
          color: Colors.grey[300],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                  ),
                  color : Colors.white,
                ),
                child: Text(type)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                width: 125,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                  ),
                  color : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Clients' , style: TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600),),
                    Text('$totalClient')
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                width: 125,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                    border: Border.all(
                      width: 8,
                      color: Colors.white
                    ),
                    color : Colors.white,
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Amount' , style: TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600)),
                    Text('$totalAmount')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget amountdataLoc2(int totalClient, int totalAmount, int totalBalance, int remainingClient, String r1, String r2, String c1, String c2) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        height: size.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            width: 3,
            color: const Color.fromARGB(255, 218, 243, 219),
            // style: BorderStyle.solid,
          ),
          color: const Color.fromARGB(255, 218, 243, 219),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 0,),
                Text(r1,style: const TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600)),
                Text(r2,style: const TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(c1,style: const TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600)),
                Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                width: size.width*0.25,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                  ),
                  color : Colors.white,
                ),
                child: Center(child: Text('$totalClient'))
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                width: size.width*0.25,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                  ),
                  color : Colors.white,
                ),
                child: Center(child: Text('$totalAmount'))
              ),
            ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(c2,style: const TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600)),
                Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                width: size.width*0.25,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                  ),
                  color : Colors.white,
                ),
                child: Center(child: Text('$remainingClient'))
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top :5.0, bottom: 5.0),
              child: Container(
                width: size.width*0.25,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                  ),
                  color : Colors.white,
                ),
                child: Center(child: Text('$totalBalance'))
              ),
            ),
              ],
            )
          ],
        ),
      )
    );
  }


}
