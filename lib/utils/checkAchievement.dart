import '../models/user_model.dart';

void checkAchievement({required User user}){
  checkFirstDrink(user: user);
}

bool checkFirstDrink({required User user}){
  if(user.drinkAttempt! >= 1){
    return true;
  }
  return false;
}

bool checkSevenDaysStreak({required User user}){
  if(user.targetHit! >= 7){
    return true;
  }
  return false;
}