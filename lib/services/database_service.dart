import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hyjoden/models/achievement_model.dart';
import 'package:hyjoden/models/history_model.dart';
import 'package:hyjoden/models/user_model.dart';

import '../models/drink_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  Future<void> createUserFromModel({required User user}) async {
    final docUser = _firebaseStore.collection('users').doc(user.uid);
    final Map<String, dynamic> userInfo = user.toMap();
    await docUser.set(userInfo);
  }

  Future<User?> getUserFromUid({required uid}) async {
    final docUser = _firebaseStore.collection('users').doc(uid);
    final snapshot = await docUser.get();

    if (!snapshot.exists) return null;
    final userInfo = snapshot.data();
    final user = User.fromMap(userMap: userInfo!);

    return user;
  }

  Future<void> updateUserFromUid({required uid, required User user}) async {
    final docUser = _firebaseStore.collection('users').doc(uid);
    final newUserInfo = user.toMap();

    docUser.set(newUserInfo);
  }

  // Stream<List<Drink>> getStreamListDrink() => _firebaseStore
  //     .collection('drinks')
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs
  //         .map((doc) => Drink.fromMap(drinkMap: doc.data()))
  //         .toList());

  Stream<List<History>> getStreamListHistory({required uid}) => _firebaseStore
      .collection('users')
      .doc('${uid}')
      .collection('history')
      .orderBy('time', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => History.fromMap(historyMap: doc.data()))
          .toList());
  Stream<List<Achievement>> getStreamListAchievement({required uid}) =>
      _firebaseStore
          .collection('users')
          .doc('${uid}')
          .collection('achievements')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Achievement.fromMap(achievementMap: doc.data()))
              .toList());
  // Stream<List<Achievement>> getStreamListAchievement() => _firebaseStore
  //     .collection('achievements')
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs
  //         .map((doc) => Achievement.fromMap(achievementMap: doc.data()))
  //         .toList());

  Future<void> addHistory({required History history, required uid}) async {
    _firebaseStore
        .collection('users')
        .doc(uid)
        .collection('history')
        .add(history.toMap())
        .then((documentSnapshot) => _firebaseStore
            .collection('users')
            .doc(uid)
            .collection('history')
            .doc('${documentSnapshot.id}')
            .update({'id': '${documentSnapshot.id}'}));
  }

  Future<void> addAchievement(
      {required Achievement achievement, required uid}) async {
    _firebaseStore
        .collection('users')
        .doc(uid)
        .collection('achievements')
        .doc('${achievement.id}')
        .set(achievement.toMap());
    // .then((documentSnapshot) => _firebaseStore
    //     .collection('users')
    //     .doc(uid)
    //     .collection('achievements')
    //     .doc('${documentSnapshot.id}')
    //     .update({'id': '${documentSnapshot.id}'}));
  }
  // Future<void> addAchievement(
  //     {required Achievement achievement, required uid}) async {
  //   _firebaseStore
  //       .collection('users')
  //       .doc(uid)
  //       .collection('achievements')
  //       .add(achievement.toMap())
  //       .then((documentSnapshot) => _firebaseStore
  //           .collection('users')
  //           .doc(uid)
  //           .collection('achievements')
  //           .doc('${documentSnapshot.id}')
  //           .update({'id': '${documentSnapshot.id}'}));
  // }

  void set_archievements({required User user}) {
    Achievement achievement1 = Achievement(
        name: 'First Drink!',
        id: 'achievement1',
        detail: 'Take your first drink.',
        unlocked: false);
    Achievement achievement2 = Achievement(
        name: 'First Success',
        id: 'achievement2',
        detail: 'Reach your goal for the first time.',
        unlocked: false);
    Achievement achievement3 = Achievement(
        name: '5 Days Streak',
        id: 'achievement3',
        detail: 'Reach your goal for 5 consecutive days.',
        unlocked: false);
    Achievement achievement4 = Achievement(
        name: '7 Days Streak',
        id: 'achievement4',
        detail: 'Reach your goal for 7 consecutive days',
        unlocked: false);
    Achievement achievement5 = Achievement(
        name: 'Apprentice Water Drinkers',
        id: 'achievement5',
        detail: 'Drink total up to 10 liters.',
        unlocked: false);
    Achievement achievement6 = Achievement(
        name: 'Beginner Water Drinkers',
        id: 'achievement6',
        detail: 'Drink total up to 100 liters.',
        unlocked: false);
    Achievement achievement7 = Achievement(
        name: 'Expert Water Drinkers',
        id: 'achievement7',
        detail: 'Drink total up to 1000 liters.',
        unlocked: false);
    addAchievement(achievement: achievement1, uid: user.uid);
    addAchievement(achievement: achievement2, uid: user.uid);
    addAchievement(achievement: achievement3, uid: user.uid);
    addAchievement(achievement: achievement4, uid: user.uid);
    addAchievement(achievement: achievement5, uid: user.uid);
    addAchievement(achievement: achievement6, uid: user.uid);
    addAchievement(achievement: achievement7, uid: user.uid);
  }

  // void checkAchievement({required User user}) {

  //   checkFirstDrink(user: user);
  //   checkFirstSuccess(user: user);
  //   checkFiveDaysStreak(user: user);
  //   checkSevenDaysStreak(user: user);
  //   checkTenLitre(user: user);
  //   checkHundredLitre(user: user);
  //   checkThousandLitre(user: user);
  // }
  Future<void> checkAchievement({required User user}) async {
    int count = 0;
    if (checkFirstDrink(user: user)) count += 1;
    if (checkFirstSuccess(user: user)) count += 1;
    if (checkFiveDaysStreak(user: user)) count += 1;
    if (checkSevenDaysStreak(user: user)) count += 1;
    if (checkTenLitre(user: user)) count += 1;
    if (checkHundredLitre(user: user)) count += 1;
    if (checkThousandLitre(user: user)) count += 1;
    user.achievementCount = count;
    updateUserFromUid(uid: user.uid, user: user);
  }

  int countAchievement({required User user}) {
    int count = 0;
    if (checkFirstDrink(user: user)) count += 1;
    if (checkFirstSuccess(user: user)) count += 1;
    if (checkFiveDaysStreak(user: user)) count += 1;
    if (checkSevenDaysStreak(user: user)) count += 1;
    if (checkTenLitre(user: user)) count += 1;
    if (checkHundredLitre(user: user)) count += 1;
    if (checkThousandLitre(user: user)) count += 1;
    return count;
  }

  bool checkFirstDrink({required User user}) {
    if (user.drinkAttempt! >= 1) {
      _firebaseStore
          .collection('users')
          .doc(user.uid)
          .collection('achievements')
          .doc("achievement1")
          .update({'unlocked': true});
      return true;
    }
    return false;
  }

  bool checkFirstSuccess({required User user}) {
    if (user.targetHit! >= 1) {
      _firebaseStore
          .collection('users')
          .doc(user.uid)
          .collection('achievements')
          .doc("achievement2")
          .update({'unlocked': true});
      return true;
    }
    return false;
  }

  bool checkFiveDaysStreak({required User user}) {
    if (user.targetHit! >= 5) {
      _firebaseStore
          .collection('users')
          .doc(user.uid)
          .collection('achievements')
          .doc("achievement3")
          .update({'unlocked': true});
      return true;
    }
    return false;
  }

  bool checkSevenDaysStreak({required User user}) {
    if (user.targetHit! >= 7) {
      _firebaseStore
          .collection('users')
          .doc(user.uid)
          .collection('achievements')
          .doc("achievement4")
          .update({'unlocked': true});
      return true;
    }
    return false;
  }

  bool checkTenLitre({required User user}) {
    if (user.totalDrink! >= 10000) {
      _firebaseStore
          .collection('users')
          .doc(user.uid)
          .collection('achievements')
          .doc("achievement5")
          .update({'unlocked': true});
      return true;
    }
    return false;
  }

  bool checkHundredLitre({required User user}) {
    if (user.totalDrink! >= 100000) {
      _firebaseStore
          .collection('users')
          .doc(user.uid)
          .collection('achievements')
          .doc("achievement6")
          .update({'unlocked': true});
      return true;
    }
    return false;
  }

  bool checkThousandLitre({required User user}) {
    if (user.totalDrink! >= 100000) {
      _firebaseStore
          .collection('users')
          .doc(user.uid)
          .collection('achievements')
          .doc("achievement7")
          .update({'unlocked': true});
      return true;
    }
    return false;
  }
}
