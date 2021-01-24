import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

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
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 30,
                    child: FittedBox(
                        child: Text(
                      "\$${userTransaction[index].amount}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                  ),
                  title: Text(
                    userTransaction[index].title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransaction[index].date),
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
                              deleteItem(userTransaction[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteItem(userTransaction[index].id)),
                ),
              );
            },
            itemCount: userTransaction.length,
          );
  }
}
