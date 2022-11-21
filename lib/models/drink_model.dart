class Drink {
  final String name;
  final int amount;
  final int price;
  final int sugar;

  Drink(
      {required this.name,
      required this.amount,
      required this.price,
      required this.sugar});

  Drink.fromMap({required Map<String, dynamic> drinkMap})
      : name = drinkMap['name'],
        amount = drinkMap['amount'],
        price = drinkMap['price'],
        sugar = drinkMap['sugar'];

  Map<String, dynamic> toMap() => {
        'name': name,
        'amount': amount,
        'price': price,
        'sugar': sugar,
      };
}
