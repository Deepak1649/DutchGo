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
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: <Widget>[
                Text('No expenses Yet',
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraint.maxHeight * 0.6,
                    child: Image.asset('Assets/Images/waiting.png'))
              ],
            );
          })
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
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          onPressed: () {
                            deleteTx(transactions[index].id);
                          },
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                        )
                      : IconButton(
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
