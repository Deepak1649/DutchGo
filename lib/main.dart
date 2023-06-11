import 'package:flutter/services.dart';

import 'Models/transactions.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transactions_list.dart';
import 'package:flutter/material.dart';
import 'widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.yellow,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              // textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'OpenSans',fontSize: 20,),),
              )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   obj: 'new ps4',
    //   price: 699.98,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   obj: 'new xbox',
    //   price: 799.98,
    //   date: DateTime.now(),
    // )
  ];

  bool _showchart = false;

  List<Transaction> get _recentTransactions {
    print(_userTransaction);
    return _userTransaction.where((rtx) {
      return rtx.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void addNewTx(String txTitle, double Amount, DateTime chosendate) {
    final newTx = Transaction(
      obj: txTitle,
      price: Amount,
      date: chosendate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addNewTx),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final _appBar = AppBar(
      title: Text(
        'Personal Expense',
        style: TextStyle(fontFamily: 'Open Sans'),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              startNewTransaction(context);
            },
            icon: Icon(Icons.add))
      ],
    );
    final txlist = Container(
        height: (MediaQuery.of(context).size.height -
                _appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Show Chart"),
                    Switch(
                      value: _showchart,
                      onChanged: (value) {
                        setState(() {
                          _showchart = value;
                        });
                      },
                    ),
                  ],
                ),
              if (!_isLandscape)
                Container(
                    height: (MediaQuery.of(context).size.height -
                            _appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(_recentTransactions)),
              if (!_isLandscape) txlist,
              if (_isLandscape)
                _showchart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                _appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: Chart(_recentTransactions))
                    : txlist,
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.yellow,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
        onPressed: () {
          startNewTransaction(context);
        },
      ),
    );
  }
}
