class MessageModel {
  String receiverId;
  String senderId;
  String text;
  String dateTime;
  String image;


  MessageModel({
    this.receiverId,
    this.senderId,
    this.text,
    this.dateTime,
    this.image
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    text = json['text'];
    dateTime = json['dateTime'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverId,
      'senderId':senderId ,
      'text': text,
      'dateTime': dateTime,
      'image': image,
    };
  }
}
