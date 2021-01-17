import 'package:exp_tracker/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import './widget/transaction_list.dart';
import './widget/transaction_input.dart';
import './models/transaction.dart';
import './widget/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyHomePage();
    return MaterialApp(
      title: "flutter App",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
          headline1:TextStyle(fontFamily: 'OpenSans',
        fontSize:25,
        fontWeight: FontWeight.bold)
        // title:TextStyle(fontFamily: 'OpenSans',
        // fontSize:25,)
        // fontFamily: "YuseiMagic",
        // appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
        // title:TextStyle(fontFamily: 'OpenSans',
        // fontSize:25,)
        // ))
         ),
      ),
     
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
 
  ];

  List<Transaction> get _recentTransactions{
return _userTransaction.where((tx){
return tx.date.isAfter(
  DateTime.now().subtract(Duration(days: 7),),
);
}).toList();
  }

  void _addTx(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _showNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: TxInput(_addTx),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showNewTransaction(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Chart(_recentTransactions),
              TxList(_userTransaction),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNewTransaction(context),
      ),
    );
  }
}
