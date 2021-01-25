import 'package:flutter/material.dart';
import '../models/transaction.dart';

import './transaction_items.dart';

class TxList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteItem;

  TxList(this.userTransaction, this.deleteItem);

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(children: [
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
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset(
                      "assets/images/box.png",
                      fit: BoxFit.cover,
                    )),
              ]);
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(userTransaction: userTransaction[index], deleteItem: deleteItem);
            },
            itemCount: userTransaction.length,
          );
  }
}
