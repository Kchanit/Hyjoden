class History {
  final int amount;
  final String date;
  final String time;
  final String? id;

  History(
      {required this.amount,
      required this.date,
      required this.time,
      this.id});

  History.fromMap({required Map<String, dynamic> historyMap})
      : amount = historyMap['amount'],
        date = historyMap['date'],
        time = historyMap['time'],
        id = historyMap['id'];

  Map<String, dynamic> toMap() => {
        'amount': amount ,
        'date': date,
        'time': time,
        'id': id,
      };
}
