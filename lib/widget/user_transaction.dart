import 'package:flutter/material.dart';
import '../widget/transaction_input.dart';
import '../widget/transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {


  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {


  final List<Transaction> _userTransaction = [
    Transaction(
   title: "melon",
      amount: 25.55,
      date: DateTime.now(),
      id: DateTime.now().toString(),
 ),
 Transaction(
   title: "Schoo bag",
      amount: 14.99,
      date: DateTime.now(),
      id: DateTime.now().toString(),
 ),
 Transaction(
   title: "Watch",
      amount: 45.75,
      date: DateTime.now(),
      id: DateTime.now().toString(),
 )
  ];


void _addTx(String txTitle, double txAmount){
final newTx=Transaction(
   title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
 );

setState(() {
  _userTransaction.add(newTx);
});
  
}

  @override
  Widget build(BuildContext context) {
    return Column(children: [
         TxInput(_addTx),
         TxList(_userTransaction),
    ]);
}
}