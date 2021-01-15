import 'package:flutter/material.dart';
import './widget/user_transaction.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding:false,
      appBar: AppBar(
        title: Text("Expense Tracker"),
      ),
      body: SafeArea(
              child: Column(
            children: <Widget>[
              Container(
        width: double.infinity,
        child: Card(
          color: Colors.blue[100],
          child: Text("Chart!"),
          elevation: 5,
        ),
              ),
              UserTransaction(),
            ],
          ),
      ),
    );
  }
}
