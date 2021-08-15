import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/components/resuable_components.dart';
import 'package:social_app/shared/bloc/cubit/social_cubit/social_cubit.dart';
import 'package:social_app/shared/bloc/state/social_state/social_state.dart';

class PostScreen extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        final model = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text('Create Posts',
                style: Theme.of(context).textTheme.headline6),
            actions: [
              defaultTextButton(
                  press: () {
                    var date =
                        DateFormat.yMMMEd().add_jms().format(DateTime.now());
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost(
                          text: textController.text, dateTime: date.toString());
                    } else {
                      SocialCubit.get(context).upLoadPostImage(
                          text: textController.text, dateTime: date.toString());
                    }
                  },
                  text: 'POST')
            ],
          ),
          body: model != null
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialCreatePostLoadingState)
                      LinearProgressIndicator(),
                    if (state is SocialCreatePostLoadingState)
                      SizedBox(
                        height: 10.0,
                      ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: CachedNetworkImage(
                            imageUrl: '${model.profileImage}',
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            width: 45.0,
                            height: 45.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '${model.name}',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'What is in your mind ?',
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          controller: textController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    if (SocialCubit.get(context).postImage != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 140.0,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(4.0),
                                image: DecorationImage(
                                  image: FileImage(
                                      SocialCubit.get(context).postImage),
                                  fit: BoxFit.fill,
                                )),
                          ),
                          IconButton(
                            onPressed: () {
                              SocialCubit.get(context).removePostImage();
                            },
                            icon: CircleAvatar(
                              child: Icon(Icons.close),
                              radius: 15.0,
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              SocialCubit.get(context).selectPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Add Photo'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: TextButton(
                             onPressed: () {},
                             child: Text('# Tags'),
                        ),),
                      ],
                    ),
                  ],
                ),
              )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
