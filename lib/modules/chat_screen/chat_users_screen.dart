import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/resuable_components.dart';
import 'package:social_app/modules/chat_screen/chat_screen.dart';
import 'package:social_app/modules/chat_screen/widgets/chat_item_widget.dart';
import 'package:social_app/shared/bloc/cubit/social_cubit/social_cubit.dart';
import 'package:social_app/shared/bloc/state/social_state/social_state.dart';

class ChatUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SocialCubit.get(context).users.length > 0
              ? ListView.separated(
                  itemBuilder: (context, index) => InkWell(
                        child: ChatItem(
                          model: SocialCubit.get(context).users[index],
                        ),
                        onTap: () {
                          navigateTo(
                              context: context,
                              widget: ChatScreen(
                                model: SocialCubit.get(context).users[index],
                              ));
                        },
                      ),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: SocialCubit.get(context).users.length)
              : Center(child: CircularProgressIndicator());
        });
  }
}
