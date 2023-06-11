import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String obj;
  double price;
  DateTime date;

  Transaction(
      {@required this.id,
      @required this.obj,
      @required this.price,
      @required this.date});
}
