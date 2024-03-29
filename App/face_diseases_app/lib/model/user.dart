class User {
  final String name;
  final String username;
  //final String contact;
  final String image;
  final String info;
  bool isFollowedByMe;
  

  User(this.name, this.username,  this.image,this.info,this.isFollowedByMe);

  get followersCount => null;
}