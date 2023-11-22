 
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
  FirebaseFirestore.instance.collection('summary').doc(date).set(x.toMap());
  getHomeDocs();
  return x;
}

void updateSummary (String date, var key, var value) {
  if(DateTime.parse(date).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)) == 0 && summaryDates.keys.contains(date)){
    Map<String,dynamic> nm = summaryDates[date];
    nm[key] = value;
    FirebaseFirestore.instance.collection('summary').doc(date).set(nm);
    getHomeDocs();
  }else if(DateTime.parse(date).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)) == 0){
    createSummary(date);
    Map<String,dynamic> nm = summaryDates[date];
    nm[key] = value;
    FirebaseFirestore.instance.collection('summary').doc(date).set(nm);
    getHomeDocs();
  }else{
    
  }

}
