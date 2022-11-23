import 'package:hyjoden/models/drink_model.dart';

class History {
  final int amount;
  final String date;
  final String time;
  final String? id;
  final int? sugar;
  final int? price;

  History(
      {required this.amount,
      required this.date,
      required this.time,
      this.id,
      this.price,
      this.sugar});

  History.fromMap({required Map<String, dynamic> historyMap})
      : amount = historyMap['amount'],
        date = historyMap['date'],
        time = historyMap['time'],
        id = historyMap['id'],
        sugar = historyMap['sugar'],
        price = historyMap['price'];

  Map<String, dynamic> toMap() => {
        'amount': amount ,
        'date': date,
        'time': time,
        'id': id,
        'sugar': sugar ?? 0,
        'price': price ?? 0,
      };
}