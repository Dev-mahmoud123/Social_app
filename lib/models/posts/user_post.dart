class PostModel {
  String name;
  String uid;
  String profileImage;
  String text;
  String dateTime;
  String postImage;


  PostModel({
    this.name,
    this.uid,
    this.profileImage,
    this.text,
    this.dateTime,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    text = json['text'];
    profileImage = json['profileImage'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];

  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'profileImage': profileImage,
      'text': text,
      'dateTime': dateTime,
      'postImage': postImage,
    };
  }
}
