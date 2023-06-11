import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleupdate = TextEditingController();

  final _amountupdate = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = _titleupdate.text;
    final enteredAmount = double.parse(_amountupdate.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addtx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
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
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Enter the cost'),
              controller: _amountupdate,
              keyboardType: TextInputType.number,
              // onChanged: (val) {
              //   amountupdate = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Enter the label '),
              controller: _titleupdate,
              onSubmitted: (_) => submitData(),
              // onChanged: (vali) {
              //   titleupdate = vali;
              // },
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No dates chosen'
                        : 'Picked date :${DateFormat.yMd().format(_selectedDate)}',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: _datePicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(
                          fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                submitData();
              },
              child: Text(
                'DONE',
                style: TextStyle(
                    fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
