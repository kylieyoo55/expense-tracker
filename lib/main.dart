import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:exp_tracker/widget/transaction_list.dart';
import 'package:flutter/material.dart';

import './widget/transaction_list.dart';
import './widget/transaction_input.dart';
import './models/transaction.dart';
import './widget/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyHomePage();
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            button: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
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
  final List<Transaction> _userTransaction = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTx(String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: selectedDate,
      //DateTime.now(),
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((el) => el.id == id);
    });
  }

//build when LandScape mode
  List<Widget> _buildLandscapeCentent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline1,
          ),
          //change the look depends OS system
          Switch.adaptive(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              child: Chart(_recentTransactions),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
            )
          : txListWidget,
    ];
  }

//only excute when portrait(horizon )mode
  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
        child: Chart(_recentTransactions),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
      ),
      txListWidget
    ];
  }

//build Cupertino when IOS( Automactically detected)
  Widget _buildCupertino() {
    return CupertinoNavigationBar(
      middle: Text("Expense Tracker"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _showNewTransaction(context),
          )
        ],
      ),
    );
  }
//build AppBar when Android

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        "Expense Tracker",
        style: TextStyle(
          color: Colors.white,
        ),
      ),

      //button
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showNewTransaction(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //MediaQuery variable
    var mediaQuery = MediaQuery.of(context);
    //LandScape Orientation
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    //AppBar
    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildCupertino() : _buildAppBar();

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.5,
      child: TxList(_userTransaction, _deleteTransaction),
    );

//body
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeCentent(mediaQuery, appBar, txListWidget),
            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar, txListWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showNewTransaction(context),
                  ),
          );
  }
}
