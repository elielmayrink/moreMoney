import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactoin extends StatefulWidget {
  final Function newTransaction;
  NewTransactoin(
    this.newTransaction,
  );

  @override
  _NewTransactoinState createState() => _NewTransactoinState();
}

class _NewTransactoinState extends State<NewTransactoin> {
  final _titleControler = TextEditingController();

  final _amountControler = TextEditingController();

  DateTime _selectDate;

  void _submitData() {
    final titleInFunc = _titleControler.text;
    final amountInFunc = double.parse(_amountControler.text);
    final date = _selectDate == null ? DateTime.now() : _selectDate;

    if (titleInFunc.isEmpty || amountInFunc == 0) {
      return;
    }

    widget.newTransaction(titleInFunc, amountInFunc, date);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: _titleControler,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: _amountControler,
              ),
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _selectDate == null
                          ? "No Date Chosen"
                          : DateFormat.yMd().format(_selectDate),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.all(5),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  padding: EdgeInsets.all(5),
                  onPressed: _submitData,
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
