/*class User {
  final String id;
  final String name;
  final String username; // Used as 'hospital'
  final String image;
  final String info;
  final bool isFollowedByMe;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.image,
    required this.info,
    required this.isFollowedByMe,
  });

  factory User.fromFirestore(Map<String, dynamic> firestore) {
    return User(
      id: firestore['id'] ?? '',
      name: firestore['name'],
      username: firestore['username'],
      image: firestore['imageUrl'],
      info: firestore['info'],
      isFollowedByMe: firestore['isFollowed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'imageUrl': image,
      'info': info,
      'isFollowed': isFollowedByMe,
    };
  }
}*/
