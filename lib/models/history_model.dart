class History {
  final String name;
  final int amount;
  final String day;
  final String date;
  final String time;
  final String? id;
  final double? sugar;
  final double? price;
  final String? imageName;

  History(
      {required this.name,
      required this.amount,
      required this.day,
      required this.date,
      required this.time,
      this.id,
      this.price,
      this.sugar,
      required this.imageName});

  History.fromMap({required Map<String, dynamic> historyMap})
      : name = historyMap['name'],
        amount = historyMap['amount'],
        day = historyMap['day'],
        date = historyMap['date'],
        time = historyMap['time'],
        id = historyMap['id'],
        sugar = historyMap['sugar'],
        price = historyMap['price'],
        imageName = historyMap['imagePath'];

  Map<String, dynamic> toMap() => {
        'name': name,
        'amount': amount,
        'day': day,
        'date': date,
        'time': time,
        'id': id,
        'sugar': sugar ?? 0.0,
        'price': price ?? 0.0,
        'imagePath': imageName ?? '',
      };
}
