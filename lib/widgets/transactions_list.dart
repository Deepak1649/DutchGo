import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text('No expenses Yet',
                  style: TextStyle(fontFamily: 'OpenSans', fontSize: 20)),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 300, child: Image.asset('Assets/Images/waiting.png'))
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Text('Rs ${transactions[index].price}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].obj,
                    style: TextStyle(
                        fontFamily: 'QuickSand', fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(
                      transactions[index].date,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      deleteTx(transactions[index].id);
                    },
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
