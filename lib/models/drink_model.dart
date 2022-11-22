class Drink {
  final String? name;
  final int amount;
  final int? price;
  final int? sugar;

  Drink(
      {this.name,
      required this.amount,
      this.price,
      this.sugar});

  Drink.fromMap({required Map<String, dynamic> drinkMap})
      : name = drinkMap['name'],
        amount = drinkMap['amount'],
        price = drinkMap['price'],
        sugar = drinkMap['sugar'];

  Map<String, dynamic> toMap() => {
        'name': name ?? 'water',
        'amount': amount,
        'price': price ?? 0,
        'sugar': sugar ?? 0,
      };
}
