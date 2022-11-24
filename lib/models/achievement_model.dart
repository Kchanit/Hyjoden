class Achievement {
  final String name;
  final String detail;
  final String? id;
  bool unlocked;

  Achievement({required this.name, required this.detail,required this.id, required this.unlocked});

  Achievement.fromMap({required Map<String, dynamic> achievementMap})
      : name = achievementMap['name'],
        detail = achievementMap['detail'],
        id = achievementMap['id'],
        unlocked = achievementMap['unlocked'];

  Map<String, dynamic> toMap() => {
        'name': name,
        'detail': detail,
        'id': id,
        'unlocked': unlocked,
      };
}
