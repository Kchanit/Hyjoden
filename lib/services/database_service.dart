import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<List<Drink>> getStreamListDrink() => _firebaseStore
      .collection('drinks')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Drink.fromMap(drinkMap: doc.data()))
          .toList());

  Future<void> addHistory({required Drink drink, required uid}) async {
    _firebaseStore
        .collection('users')
        .doc(uid)
        .collection('history')
        .add(drink.toMap())
        .then((documentSnapshot) => _firebaseStore
            .collection('users')
            .doc(uid)
            .collection('history')
            .doc('${documentSnapshot.id}')
            .update({'uid': '${documentSnapshot.id}'}));
  }
}
