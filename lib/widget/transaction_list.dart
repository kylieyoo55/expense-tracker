import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TxList extends StatelessWidget {
  final List<Transaction> userTransaction;

  TxList(this.userTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: userTransaction.isEmpty
            ? Column(children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No transaction added yet",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      "assets/images/raining.png",
                      fit: BoxFit.cover,
                    )),
              ])
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                              "\$${userTransaction[index].amount.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          padding: EdgeInsets.all(10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userTransaction[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              DateFormat.yMEd()
                                  .format(userTransaction[index].date),
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[600]),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: userTransaction.length,
              ));
  }
}
