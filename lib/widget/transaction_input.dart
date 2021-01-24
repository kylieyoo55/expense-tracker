import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_button.dart';

class TxInput extends StatefulWidget {
  final Function newTx;

  TxInput(this.newTx);

  @override
  _TxInputState createState() => _TxInputState();
}

class _TxInputState extends State<TxInput> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {

    if(_amountController.text.isEmpty){
      return;
    }
    
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
final DateTime pickedDate= _selectedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || pickedDate ==null) {
      return;
    }

    widget.newTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top:10,
          left:10,
          right:10,
          bottom:MediaQuery.of(context).viewInsets.bottom+10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => _submitData,
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                onSubmitted: (_) => _submitData,
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No Date Chosen"
                            : "Picked Date:${DateFormat.yMd().format(_selectedDate)}",
                      ),
                    ),
                    AdaptiveButton("Choose Date", _presentDatePicker)
                  ],
                ),
              ),
              Container(
                height: 60,
                child: FlatButton(
                    onPressed: _submitData,
                    child: Text(
                      "Add Transaction",
                      style: Theme.of(context).textTheme.button,
                    ),
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
