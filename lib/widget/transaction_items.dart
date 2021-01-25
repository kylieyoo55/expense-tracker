import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    
    @required this.userTransaction,
    @required this.deleteItem,
  }) ;

  final Transaction userTransaction;
  final Function deleteItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 30,
          child: FittedBox(
              child: Text(
            "\$${userTransaction.amount}",
            style: TextStyle(
              color: Colors.white,
            ),
          )),
        ),
        title: Text(
          userTransaction.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                icon: Icon(
                  Icons.delete,
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(),
                ),
                textColor: Theme.of(context).errorColor,
                onPressed: () =>
                    deleteItem(userTransaction.id),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    deleteItem(userTransaction.id)),
      ),
    );
  }
}
