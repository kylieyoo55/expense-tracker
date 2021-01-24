
import './chard_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i< recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    }).reversed.toList();
  }
double get totalSpending{
  return groupedTransactionValues.fold(0.0, (sum, el){
return sum+el["amount"];
  });
}

  @override
  Widget build(BuildContext context) {
   
    return Container(
      height: MediaQuery.of(context).size.height*0.26,
          child: Card(
        margin: EdgeInsets.all(20),
        elevation: 6,
        child: Container(
          padding: EdgeInsets.all(10),
                child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues.map((el){
              return Flexible(
                fit: FlexFit.tight,
                          child: ChartBar(
                  label:el["day"],
                  spendingAmount: el["amount"] ,
                  spendingPct: totalSpending== 0.0 ? 0.0 :(el["amount"] as double)/totalSpending,),
              );
              // Text("${el["day"]} : ${el["amount"].toString()}");
            }).toList(),
          ),
        ),
      ),
    );
  }
}
