 
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'home.dart';

final _firestone = FirebaseFirestore.instance;
var fb = FirebaseFirestore.instance.collection('summary');

var summaryDates = {};
var summaryTiles = [];

Future<bool> getHomeDocs () async {
  
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await _firestone.collection("summary").get();
    summaryTiles = querySnapshot.docs.toList();
    for (var tile in summaryTiles) {
      summaryDates.addAll({tile.id: tile.data()});
    }
    return false;
  
}

 Home todaysData (String date) {
    
    if(summaryDates.keys.contains(date)){
      return Home.fromMap(summaryDates[date]);
    }
    else{
      return _createSummary(date);
    }
  }

Home _createSummary (String date) {
  List d = summaryDates.keys.toList();
  int prevDateIndex = 0;
  for(int i = d.length-1;i>=0;i--){
    prevDateIndex = i;
    if(DateTime.parse(date).compareTo(DateTime.parse(d[i]))>0){
      break;
    }
  }
  Home x = Home.fromMap(summaryDates[d[prevDateIndex]]);
  x.newAccount = 0;x.newAmount = 0;
  x.closedAccount = 0;x.closedAmount = 0;
  FirebaseFirestore.instance.collection('summary').doc(date).set(x.toMap());
  getHomeDocs();
  return x;
}

void updateSummary (String date, var key, var value) {
  if(DateTime.parse(date).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)) == 0 && summaryDates.keys.contains(date)){
    _updateSummaryHelper(date, key, value);
  }else if(DateTime.parse(date).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)) == 0){
    _createSummary(date);
    _updateSummaryHelper(date, key, value);
  }else{
    if(!summaryDates.keys.contains(date)){
      _createSummary(date);
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
        _updateSummaryHelper(d[i], key, value);
      }
  }
}

void _updateSummaryHelper(String date, int key, var value) {
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
        nm['totalClient'] += 1;
        nm['totalAmount'] += value;
        break;
      }
      case 3 : {
        nm['newAccount'] = nm['newAccount'] + 1;
        nm['newAmount'] = nm['newAmount'] + value;
        nm['clientB'] = nm['clientB'] + 1;
        nm['amountB'] = nm['amountB'] + value;
        nm['totalClient'] += 1;
        nm['totalAmount'] += value;
        break;
      }
      case 4 : {
        nm['closedAccount'] = nm['closedAccount'] + 1;
        nm['closedAmount'] = nm['closedAmount'] + value;
        nm['clientA'] = nm['clientA'] - 1;
        nm['amountA'] = nm['amountA'] - value;
        nm['totalClient'] -= 1;
        nm['totalAmount'] -= value;
        break;
      }
      case 5 : {
        nm['closedAccount'] = nm['closedAccount'] + 1;
        nm['closedAmount'] = nm['closedAmount'] + value;
        nm['clientB'] = nm['clientB'] - 1;
        nm['amountB'] = nm['amountB'] - value;
        nm['totalClient'] -= 1;
        nm['totalAmount'] -= value;
        break;
      }
      case 6 : {
        nm['totalBalance'] = nm['totalBalance'] + value;
        break;
      }
    } 
    FirebaseFirestore.instance.collection('summary').doc(date).set(nm);
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
*/