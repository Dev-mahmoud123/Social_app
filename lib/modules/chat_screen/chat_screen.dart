import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/models/user/user.dart';
import 'package:social_app/modules/chat_screen/widgets/left_message_widget.dart';
import 'package:social_app/modules/chat_screen/widgets/right_message_widget.dart';
import 'package:social_app/shared/bloc/cubit/social_cubit/social_cubit.dart';
import 'package:social_app/shared/bloc/state/social_state/social_state.dart';

class ChatScreen extends StatelessWidget {
  final UserModel model;

  ChatScreen({Key key, this.model}) : super(key: key);

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Builder(
          builder: (context) {
            SocialCubit.get(context).getMessage(receiverId: model.uid);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1.0,
                titleSpacing: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(model.profileImage),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      model.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SocialCubit.get(context).messages.length > 0
                          ? ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var message =
                                    SocialCubit.get(context).messages[index];

                                if (SocialCubit.get(context).userModel.uid ==
                                    message.senderId)
                                  return RightMessage(
                                    model: message,
                                  );
                                return LeftMessage(
                                  model: message,
                                );
                              },
                              itemCount:
                                  SocialCubit.get(context).messages.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10.0,
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300], width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              SocialCubit.get(context).selectMessageImage();
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Write your message..',
                                    border: InputBorder.none),
                                controller: messageController,
                                maxLines: null,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.teal,
                            child: IconButton(
                              onPressed: () {
                                if (SocialCubit.get(context).messageImage ==
                                    null)
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: model.uid,
                                    text: messageController.text,
                                    dateTime: DateFormat.jm()
                                        .format(DateTime.now()),
                                  );
                                SocialCubit.get(context).upLoadMessageImage(
                                  receiverId: model.uid,
                                  text: messageController.text,
                                  dateTime: DateFormat.jm()
                                      .format(DateTime.now()),
                                );
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    if (SocialCubit.get(context).messageImage != null)
                      Image(
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        image: FileImage(SocialCubit.get(context).messageImage),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
