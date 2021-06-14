import 'package:hive/hive.dart';
part 'trades.g.dart';

@HiveType(typeId: 0)
class Trades extends HiveObject {
  @HiveField(0)
  final String stockName;
  @HiveField(1)
  double stockPrice;
  @HiveField(2)
  double valueofstock;
  @HiveField(3)
  int qty;
  @HiveField(4)
  DateTime day;
  @HiveField(5)
  double profitandloss;
  Trades(
      {required this.stockName,
      required this.stockPrice,
      required this.valueofstock,
      required this.day,
      required this.qty,
      required this.profitandloss});
}
