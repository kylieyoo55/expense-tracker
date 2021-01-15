import 'package:flutter/material.dart';

class TxInput extends StatelessWidget {
  final Function newTx;

  TxInput(this.newTx);

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  
  void submitData() {
    final enteredTitle=titleController.text;
    final enteredAmount=double.parse(amountController.text);
if(enteredTitle.isEmpty || enteredAmount <= 0){
return;
}

    newTx(
      enteredTitle,
      enteredAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              
              onSubmitted: (_) => submitData,
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => submitData,
              keyboardType: TextInputType.number,
            ),
            FlatButton(
              onPressed: submitData,
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
