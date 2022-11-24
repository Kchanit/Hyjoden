import '../models/user_model.dart';

String checkAchievement({required User user}) {
  String? temp = '0,1,2';
  if(checkFirstDrink(user: user)){
    // temp.replaceAll('A', '0');
    temp.replaceAll('0', 'A');
  }
  if(checkSevenDaysStreak(user: user)){
    // temp.replaceAll('B', '1');
    temp.replaceAll('1', 'B');
  }
  if(checkTenLitre(user: user)){
    // temp.replaceAll('C', '2');
    temp.replaceAll('2', 'C');
  }
  return temp;
}


bool checkFirstDrink({required User user}) {
  if (user.drinkAttempt! >= 1) {
    return true;
  }
  return false;
}

bool checkSevenDaysStreak({required User user}) {
  if (user.targetHit! >= 7) {
    return true;
  }
  return false;
}

bool checkTenLitre({required User user}) {
  if (user.totalDrink! >= 10000) {
    return true;
  }
  return false;
}
