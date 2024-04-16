/*class User {
  final String name;
  final String username;
  //final String contact;
  final String image;
  final String info;
  bool isFollowedByMe;
  

  User(this.name, this.username,  this.image,this.info,this.isFollowedByMe);

  get followersCount => null;
}*/



class User {
  final String id;
  final String name;
  final String username; // This could be the hospital name or similar
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

  factory User.fromFirestore(Map<String, dynamic> firestore, String id) {
    return User(
      id: id,
      name: firestore['name'] ?? 'No Name Provided',
      username: firestore['username'] ?? 'No Username',
      image: firestore['imageUrl'] ?? 'default_image.jpg',
      info: firestore['info'] ?? 'No Information Available',
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
}
