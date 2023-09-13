import 'package:flutter/material.dart';


Widget amountdata(int totalClient, int totalAmount, int totalBalance, context) {
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
                child: Text('$totalClient')
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
                    const Text('Amount' , style: TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600),),
                    Text('$totalAmount')
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
                    const Text('Balance' , style: TextStyle(color: Color(0xff32B9AE) , fontWeight: FontWeight.w600)),
                    Text('$totalBalance')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }