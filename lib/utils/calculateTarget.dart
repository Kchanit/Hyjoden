import 'package:hyjoden/models/user_model.dart';

double calculateTarget({required User user}) {
  int multiplyBy;
  double result;
  int age = user.age!;
  int weight = user.weight!;
  if (age < 30) {
    multiplyBy = 40;
  } else if (age <= 55) {
    multiplyBy = 35;
  } else {
    multiplyBy = 30;
  }
  result = (weight * multiplyBy).toDouble();
  result = result / 28.3; // oz
  result = result * 29.5; //to ml

  return result;
}


