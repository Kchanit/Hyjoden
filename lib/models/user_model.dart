class User {
  final String uid;
  final String email;
  final String username;
  int? age;
  String? bedtime;
  String? waketime;
  double? favContainer;
  final String? gender;
  int? height;
  int? weight;
  final double? target;
  final int? targetHit;
  final double? todayDrink;
  final double? totalDrink;

  User(
      {required this.uid,
      required this.email,
      required this.username,
      this.age,
      this.bedtime,
      this.waketime,
      this.favContainer,
      this.gender,
      this.weight,
      this.height,
      this.target,
      this.targetHit,
      this.todayDrink,
      this.totalDrink,
      });

  User.fromMap({required Map<String, dynamic> userMap})
      : uid = userMap['uid'],
        email = userMap['email'],
        username = userMap['username'],
        age = userMap['age'],
        bedtime = userMap['bedtime'],
        waketime = userMap['waketime'],
        favContainer = userMap['favContainer'],
        gender = userMap['gender'],
        weight = userMap['weight'],
        height = userMap['height'],
        target = userMap['target'],
        targetHit = userMap['targetHit'],
        todayDrink = userMap['todayDrink'],
        totalDrink = userMap['totalDrink'];

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'username': username,
        'age': age,
        'bedtime' : bedtime,
        'waketime': waketime,
        'favContainer': favContainer,
        'gender': gender,
        'weight': weight,
        'height': height,
        'target': target,
        'targetHit': targetHit ?? 0,
        'todayDrink': todayDrink ?? 0,
        'totalDrink' : totalDrink ?? 0,
      };
}
