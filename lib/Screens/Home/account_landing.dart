import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeLanding extends StatefulWidget {
  const HomeLanding({super.key});

  @override
  State<HomeLanding> createState() => _HomeLandingState();
}

class _HomeLandingState extends State<HomeLanding> {
  DateTime date = DateTime.now();
  bool _isloading = true;
  late final _firestone = FirebaseFirestore.instance;
  var dates = {};
  Map<String, dynamic>? ma = {};
  int depositedAmount = 0;
  int closedAmount = 0 ;
  int totalBalance = 0 ;
  int pendingAccount = 0 ;
  int closedAccount = 0;
  int newAccount = 0 ;
  int totalAmount = 0 ; 
  int depositedAccount = 0 ; 
  int newAmount = 0 ;
  int totalAccount = 0 ;
  int pendingAmount = 0;


  Future<bool> getDocs () async {
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await _firestone.collection("summary").get();
    var tiles = querySnapshot.docs.toList();
    for (var tile in tiles) {
      dates.addAll({tile.id: tile.data()});
    }
    return false;
  
  }

  void getNewData() async {
    ma = dates['${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}'];
    depositedAmount = 0;
    closedAmount = 0 ;
    totalBalance = 0 ;
    pendingAccount = 0 ;
    closedAccount = 0;
    newAccount = 0 ;
    totalAmount = 0 ; 
    depositedAccount = 0 ; 
    newAmount = 0 ;
    totalAccount = 0 ;
    pendingAmount = 0;
    if(ma != null) {
      ma!.forEach((key, value) {
        depositedAmount +=  value['DepositedAmount'] as int;
        closedAmount +=  value['ClosedAmount'] as int ;
        totalBalance +=  value['TotalBalance'] as int ;
        pendingAccount +=  value['PendingAccount'] as int ;
        closedAccount +=  value['ClosedAccount'] as int;
        newAccount +=  value['NewAccount'] as int ;
        totalAmount +=  value['TotalAmount'] as int ; 
        depositedAccount +=  value['DepositedAccount'] as int ; 
        newAmount +=  value['NewAmount'] as int ;
        totalAccount +=  value['TotalAccount'] as int ;
        pendingAmount +=  value['PendingAmount'] as int;
       });
    }
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
    getNewData();
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
                      lastDate: DateTime(2100));
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
                        TextButton(onPressed: (){}, child: const Text('View Report'))
                      ],
                    ),
                    amountdataLoc(totalAccount, totalAmount, 'All'),
                    amountdataLoc(54, 10000, 'A'),
                    amountdataLoc(54, 10000, 'B'),
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
                    amountdataLoc2(totalAccount, totalAccount, pendingAmount, pendingAccount, 'Accounts', 'Amount', 'Total', 'Remaining'),
                    const SizedBox(height: 15,),
                    const Text('Deposited'),
                    amountdataLoc2(1000, 1000000, 900000, 900, 'Accounts', 'Deposited', 'Total', 'Remaining'),
                    const SizedBox(height: 20,),
                    const Text('2nd HALF-B'),
                    const SizedBox(height: 20,),
                    const Text('Pending'),
                    amountdataLoc2(1000, 1000000, 900000, 900, 'Accounts', 'Amount', 'Total', 'Remaining'),
                    const SizedBox(height: 15,),
                    const Text('Deposited'),
                    amountdataLoc2(1000, 1000000, 900000, 900, 'Accounts', 'Deposited', 'Total', 'Remaining'),
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
                          child: const Center(child: Text("1200000",style: TextStyle(fontSize: 20),))
                        ),
                      ),
                    ]),),
                    const SizedBox(height: 20,),
                    const Text('2nd HALF-B'),
                    const SizedBox(height: 20,),
                    const Text('New & Closed Account'),
                    amountdataLoc2(newAccount, closedAccount, newAmount, closedAmount, 'New', 'Closed', 'Account', 'Amount'),
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
