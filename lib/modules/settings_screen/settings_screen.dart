import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/resuable_components.dart';
import 'package:social_app/modules/edit_profile_screen/edit_profile_screen.dart';
import 'package:social_app/shared/bloc/cubit/social_cubit/social_cubit.dart';
import 'package:social_app/shared/bloc/state/social_state/social_state.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var model = SocialCubit.get(context).userModel;
        return state is! SocialLoadingState
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 190.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0)),
                                  image: DecorationImage(
                                    image: NetworkImage('${model.cover}'),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 53.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  NetworkImage('${model.profileImage}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${model.name}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${model.bio}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '250',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'posts',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '300',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'photos',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '10K',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '500',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Followings',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text('Add Photo'),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            navigateTo(context: context , widget:  EditProfileScreen());
                          },
                          child: Icon(Icons.edit),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
