 
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'home.dart';

final _firestone = FirebaseFirestore.instance;
var fb = FirebaseFirestore.instance.collection('summary');

var summaryDates = {};
var summaryTiles = [];

Future<bool> getHomeDocs () async {
    DateTime date = DateTime.now();
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await _firestone.collection("summary").get();
    if(querySnapshot.size == 0){
      DateTime date = DateTime.now();
      Home x = Home(totalClient: 0, totalAmount: 0, clientA: 0, amountA: 0, clientB: 0, amountB: 0, A: {
        'pending': {
          'account' : 0,
          'amount' : 0
        },
        'deposit': {
          'account' : 0,
          'amount' : 0
        }
      }, B: {
        'pending': {
          'account' : 0,
          'amount' : 0
        },
        'deposit': {
          'account' : 0,
          'amount' : 0
        }
      }, totalBalance: 0, newAccount: 0, newAmount: 0, closedAmount: 0, closedAccount: 0, monthlyTotal: {
        '5 days':0,
        'Monthly':0,
      });
      await _firestone.collection('summary').doc('${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}').set(
        x.toMap()
      );
    }
    QuerySnapshot<Map<String,dynamic>> querySnapshot1 = await _firestone.collection("summary").get();
    summaryTiles = querySnapshot1.docs.toList();
    for (var tile in summaryTiles) {
      summaryDates.addAll({tile.id: tile.data()});
    }
    //updating all deposit field to false on 1st
    if(date.day == 1){
      _firestone.collection("new_account").get().then((value) {
        for (var e in value.docs) {
          e.reference.update({'deposit_field': false});
        }
      });
      _firestone.collection("new_account_d").get().then((value) {
        for (var e in value.docs) {
          e.reference.update({'deposit_field': false});
        }
      });
    }
    return false;
  
}

 Home todaysData (String date) {
    
    if(summaryDates.keys.contains(date)){
      return Home.fromMap(summaryDates[date]);
    }
    else{
      return createSummary(date);
    }
  }

Home createSummary (String date) {
  List d = summaryDates.keys.toList();
  int prevDateIndex = 0;
  for(int i = d.length-1;i>=0;i--){
    prevDateIndex = i;
    if(DateTime.parse(date).compareTo(DateTime.parse(d[i]))>0){
      break;
    }
  }
  Home x = Home.fromMap(summaryDates[d[prevDateIndex]]);
  if(DateTime.parse(date).day == 1)
  { 
    x.newAccount = 0;x.newAmount = 0;
    x.closedAccount = 0;x.closedAmount = 0;
    x.A['deposit']['amount'] = 0;
    x.A['deposit']['account'] = 0;
    x.A['pending']['amount'] = x.amountA;
    x.A['pending']['account'] = x.clientA;
    x.B['deposit']['amount'] = 0;
    x.B['deposit']['account'] = 0;
    x.B['pending']['amount'] = x.amountB;
    x.B['pending']['account'] = x.clientB;
  }
  summaryDates.addAll({date: x.toMap()});
  FirebaseFirestore.instance.collection('summary').doc(date).set(x.toMap());
  getHomeDocs();
  return x;
}

void updateSummary (String date, var key, var value, {String type = '', String plan = 'A', var bal = 0}) {
  if(DateTime.parse(date).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)) == 0 && summaryDates.keys.contains(date)){
    _updateSummaryHelper(date, key, value, type, plan, bal);
  }else if(DateTime.parse(date).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)) == 0){
    createSummary(date);
    _updateSummaryHelper(date, key, value, type, plan, bal);
  }else{
    if(!summaryDates.keys.contains(date)){
      createSummary(date);
    }
    List d = summaryDates.keys.toList();
    int dateIndex = 0;
    for(int i = d.length-1;i>=0;i--){
      dateIndex = i;
      if(DateTime.parse(date).compareTo(DateTime.parse(d[i]))==0){
        break;
      }
    }
    for(int i=dateIndex;i<summaryDates.length;i++) {
        _updateSummaryHelper(d[i], key, value, type, plan, bal);
      }
  }
}

void _updateSummaryHelper(String date, int key, int value, String type,String plan, bal) {
  Map<String,dynamic> nm = summaryDates[date];
    switch (key) {
      case 0 : {
        nm['A']['deposit']['account'] = nm['A']['deposit']['account']+1;
        nm['A']['deposit']['amount'] = nm['A']['deposit']['amount']+value;
        nm['A']['pending']['account'] = nm['A']['pending']['account']-1;
        nm['A']['pending']['amount'] = nm['A']['pending']['amount']-value;
        nm['totalBalance'] = nm['totalBalance'] - value;
        break;
      }
      case 1 : {
        nm['B']['deposit']['account'] = nm['B']['deposit']['account']+1;
        nm['B']['deposit']['amount'] = nm['B']['deposit']['amount']+value;
        nm['B']['pending']['account'] = nm['B']['pending']['account']-1;
        nm['B']['pending']['amount'] = nm['B']['pending']['amount']-value;
        nm['totalBalance'] = nm['totalBalance'] - value;
        break;
      }
      case 2 : {
        nm['newAccount'] = nm['newAccount'] + 1;
        nm['newAmount'] = nm['newAmount'] + value;
        nm['clientA'] = nm['clientA'] + 1;
        nm['amountA'] = nm['amountA'] + value;
        nm['monthlyTotal'][type] += value;
        nm['totalClient'] += 1;
        nm['totalAmount'] += value;
        nm['totalBalance'] += bal;
        nm['A']['pending']['account'] = nm['A']['pending']['account']+1;
        nm['A']['pending']['amount'] = nm['A']['pending']['amount']+value;
        break;
      }
      case 3 : {
        nm['newAccount'] = nm['newAccount'] + 1;
        nm['newAmount'] = nm['newAmount'] + value;
        nm['clientB'] = nm['clientB'] + 1;
        nm['amountB'] = nm['amountB'] + value;
        nm['monthlyTotal'][type] += value;
        nm['totalClient'] += 1;
        nm['totalAmount'] += value;
        nm['totalBalance'] += bal;
        nm['B']['pending']['account'] = nm['B']['pending']['account']+1;
        nm['B']['pending']['amount'] = nm['B']['pending']['amount']+value;
        break;
      }
      case 4 : {
        nm['closedAccount'] = nm['closedAccount'] + 1;
        nm['closedAmount'] = nm['closedAmount'] + value;
        nm['clientA'] = nm['clientA'] - 1;
        nm['amountA'] = nm['amountA'] - value;
        nm['monthlyTotal'][type] -= value;
        nm['totalClient'] -= 1;
        nm['totalAmount'] -= value;
        nm['totalBalance'] -= bal;
        nm['A']['pending']['account'] = nm['A']['pending']['account']-1;
        nm['A']['pending']['amount'] = nm['A']['pending']['amount']-value;
        break;
      }
      case 5 : {
        nm['closedAccount'] = nm['closedAccount'] + 1;
        nm['closedAmount'] = nm['closedAmount'] + value;
        nm['clientB'] = nm['clientB'] - 1;
        nm['amountB'] = nm['amountB'] - value;
        nm['monthlyTotal'][type] -= value;
        nm['totalClient'] -= 1;
        nm['totalAmount'] -= value;
        nm['totalBalance'] -= bal;
        nm['B']['pending']['account'] = nm['B']['pending']['account']-1;
        nm['B']['pending']['amount'] = nm['B']['pending']['amount']-value;
        break;
      }
      case 6 : {
        nm['totalBalance'] = nm['totalBalance'] + value;
        break;
      }
      case 7 : {
        nm['clientA'] = nm['clientA'] + 1;
        nm['amountA'] = nm['amountA'] + value;
        nm['monthlyTotal'][type] += value;
        nm['totalClient'] += 1;
        nm['totalAmount'] += value;
        nm['totalBalance'] += bal;
        nm['A']['pending']['account'] = nm['A']['pending']['account']+1;
        nm['A']['pending']['amount'] = nm['A']['pending']['amount']+value;
        break;
      }
      case 8 : {
        nm['clientB'] = nm['clientB'] + 1;
        nm['amountB'] = nm['amountB'] + value;
        nm['monthlyTotal'][type] += value;
        nm['totalClient'] += 1;
        nm['totalAmount'] += value;
        nm['totalBalance'] += bal;
        nm['B']['pending']['account'] = nm['B']['pending']['account']+1;
        nm['B']['pending']['amount'] = nm['B']['pending']['amount']+value;
        break;
      }
      case 9 : {
        nm['totalAmount'] += value;
        nm['amount$plan'] += value;
      }
    } 
    FirebaseFirestore.instance.collection('summary').doc(date).set(nm);
    getHomeDocs();
}

void addNewPlace(String date, String place){
  if(!summaryDates.keys.contains(date)){
    createSummary(date);
  }
  FirebaseFirestore.instance.collection('summary').doc(date).set({
    place : 0
  }, SetOptions(merge: true));
  getHomeDocs();
}

/*
key = 0 implies money deposited of A
    = 1           ''               B
    = 2 implies new account in A
    = 3           ''           B
    = 4 implies close account in A
    = 5           ''             B
    = 6 implies money taken(update total balance)
    = 7 implies restore account in A
    = 8           ''               B
    = 9 for updating any accounts monthly 
*/