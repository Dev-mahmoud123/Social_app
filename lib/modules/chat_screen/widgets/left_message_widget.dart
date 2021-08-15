import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/message/message.dart';
import 'package:social_app/shared/bloc/cubit/social_cubit/social_cubit.dart';

class LeftMessage extends StatelessWidget {
  final MessageModel model;

  const LeftMessage({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (model.text != '')
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                ),
                color: Colors.grey[300],
              ),
              child: Text(model.text),
            ),
          if (model.image != '')
            Padding(
              padding: const EdgeInsets.only(right: 60.0),
              child: Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: NetworkImage(model.image), fit: BoxFit.fill)),
              ),
            ),
          Text(
            model.dateTime,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
