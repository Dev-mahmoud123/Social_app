
import 'package:flutter/material.dart';
import 'package:social_app/models/user/user.dart';

class ChatItem extends StatelessWidget {
  final UserModel model;

  const ChatItem({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${model.profileImage}'),
            radius: 27.0,
          ),
          SizedBox(width: 10.0,),
          Text(
            '${model.name}',
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
