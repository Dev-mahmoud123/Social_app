import 'package:flutter/material.dart';
import 'package:social_app/models/posts/user_post.dart';
import 'package:social_app/shared/bloc/cubit/social_cubit/social_cubit.dart';
import 'package:social_app/shared/bloc/state/social_state/social_state.dart';
import 'package:social_app/style/icons/app_icons.dart';

class PostItem extends StatelessWidget {
  final PostModel model;
  final int index;
  final SocialState state;

  const PostItem({this.model, this.index, this.state}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${model.profileImage}'),
                    radius: 27.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${model.name}',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                radius: 8,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              '${model.dateTime}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: InkWell(
                      child: Image.asset(
                        AppIcons.more,
                        width: 20,
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 20.0, top: 5.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 5.0 , left: 10.0 , right: 10.0),
                child: Text('${model.text}' ,  style: Theme.of(context).textTheme.subtitle2,),
              ),
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.symmetric(horizontal: 5.0),
              //   child: Wrap(
              //     alignment: WrapAlignment.start,
              //     children: [
              //       Text(
              //         '#Software',
              //         style: TextStyle(color: Colors.blue),
              //       ),
              //       SizedBox(
              //         width: 5.0,
              //       ),
              //       Text(
              //         '#Flutter',
              //         style: TextStyle(color: Colors.blue),
              //       )
              //     ],
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            Image.asset(
                              AppIcons.heart,
                              height: 20,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}' ,
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Image.asset(
                            AppIcons.comment,
                            height: 20,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('0 comments',
                              style: Theme.of(context).textTheme.caption)
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 15.0, top: 5.0, bottom: 5.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.black12,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel.profileImage}'),
                            radius: 17.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Write a comment..',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Image.asset(
                          AppIcons.heart,
                          height: 20,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('like', style: Theme.of(context).textTheme.caption)
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
