// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Home {

  int totalClient = 0;
  int totalAmount = 0;
  int clientA = 0;
  int amountA = 0;
  int clientB = 0;
  int amountB = 0;
  Map<String,dynamic> A = {
    'totalAccount' : 0,
    'pending': {
      'remainingAccount' : 0,
      'totalAmount' : 0,
      'remainingAmount' : 0
    },
    'deposit': {
      'remainingAccount' : 0,
      'totalDeposited' : 0,
      'remainingDeposited' : 0
    }
  };
  Map<String,dynamic> B = {
    'totalAccount' : 0,
    'pending': {
      'remainingAccount' : 0,
      'totalAmount' : 0,
      'remainingAmount' : 0
    },
    'deposit': {
      'remainingAccount' : 0,
      'totalDeposited' : 0,
      'remainingDeposited' : 0
    }
  };
  int totalBalance = 0 ;
  int newAccount = 0 ;
  int newAmount = 0 ;
  int closedAmount = 0 ;
  int closedAccount = 0;
  
  Home({
    required this.totalClient,
    required this.totalAmount,
    required this.clientA,
    required this.amountA,
    required this.clientB,
    required this.amountB,
    required this.A,
    required this.B,
    required this.totalBalance,
    required this.newAccount,
    required this.newAmount,
    required this.closedAmount,
    required this.closedAccount,
  });
  
  

  Home copyWith({
    int? totalClient,
    int? totalAmount,
    int? clientA,
    int? amountA,
    int? clientB,
    int? amountB,
    Map<String,dynamic>? A,
    Map<String,dynamic>? B,
    int? totalBalance,
    int? newAccount,
    int? newAmount,
    int? closedAmount,
    int? closedAccount,
  }) {
    return Home(
      totalClient: totalClient ?? this.totalClient,
      totalAmount: totalAmount ?? this.totalAmount,
      clientA: clientA ?? this.clientA,
      amountA: amountA ?? this.amountA,
      clientB: clientB ?? this.clientB,
      amountB: amountB ?? this.amountB,
      totalBalance: totalBalance ?? this.totalBalance,
      newAccount: newAccount ?? this.newAccount,
      newAmount: newAmount ?? this.newAmount,
      closedAmount: closedAmount ?? this.closedAmount,
      closedAccount: closedAccount ?? this.closedAccount, 
      A: A ?? this.A,
      B: B ?? this.B
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalClient': totalClient,
      'totalAmount': totalAmount,
      'clientA': clientA,
      'amountA': amountA,
      'clientB': clientB,
      'amountB': amountB,
      'A': A,
      'B': B,
      'totalBalance': totalBalance,
      'newAccount': newAccount,
      'newAmount': newAmount,
      'closedAmount': closedAmount,
      'closedAccount': closedAccount,
    };
  }

  factory Home.fromMap(Map<String, dynamic> map) {
    return Home(
      totalClient: map['totalClient'] as int,
      totalAmount: map['totalAmount'] as int,
      clientA: map['clientA'] as int,
      amountA: map['amountA'] as int,
      clientB: map['clientB'] as int,
      amountB: map['amountB'] as int,
      A: map['A'] as Map<String,dynamic>,
      B: map['B'] as Map<String,dynamic>,
      totalBalance: map['totalBalance'] as int,
      newAccount: map['newAccount'] as int,
      newAmount: map['newAmount'] as int,
      closedAmount: map['closedAmount'] as int,
      closedAccount: map['closedAccount'] as int, 
    );
  }

  String toJson() => json.encode(toMap());

  factory Home.fromJson(String source) => Home.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Home(totalClient: $totalClient, totalAmount: $totalAmount, clientA: $clientA, amountA: $amountA, clientB: $clientB, amountB: $amountB, A: $A, B: $B, totalBalance: $totalBalance, newAccount: $newAccount, newAmount: $newAmount, closedAmount: $closedAmount, closedAccount: $closedAccount)';
  }

  @override
  bool operator ==(covariant Home other) {
    if (identical(this, other)) return true;
  
    return 
      other.totalClient == totalClient &&
      other.totalAmount == totalAmount &&
      other.clientA == clientA &&
      other.amountA == amountA &&
      other.clientB == clientB &&
      other.amountB == amountB &&
      other.A == A &&
      other.B == B  &&
      other.totalBalance == totalBalance &&
      other.newAccount == newAccount &&
      other.newAmount == newAmount &&
      other.closedAmount == closedAmount &&
      other.closedAccount == closedAccount;
  }

  @override
  int get hashCode {
    return totalClient.hashCode ^
      totalAmount.hashCode ^
      clientA.hashCode ^
      amountA.hashCode ^
      clientB.hashCode ^
      amountB.hashCode ^
      A.hashCode ^
      B.hashCode ^
      totalBalance.hashCode ^
      newAccount.hashCode ^
      newAmount.hashCode ^
      closedAmount.hashCode ^
      closedAccount.hashCode;
  }

  

}

