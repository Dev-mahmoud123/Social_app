class UserModel {
  String name;
  String email;
  String phone;
  String uid;
  String bio;
  bool isEmailVerified = false;
  String profileImage;
  String cover;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uid,
    this.profileImage,
    this.cover,
    this.isEmailVerified,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    bio = json['bio'];
    profileImage = json['profileImage'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'bio': bio,
      'profileImage': profileImage,
      'cover': cover,
      'isEmailVerified': isEmailVerified
    };
  }
}
