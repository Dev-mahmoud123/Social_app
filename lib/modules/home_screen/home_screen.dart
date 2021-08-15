import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home_screen/widgets/bulid_post_item.dart';
import 'package:social_app/shared/bloc/cubit/social_cubit/social_cubit.dart';
import 'package:social_app/shared/bloc/state/social_state/social_state.dart';
import 'package:social_app/style/images/app_images.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: Image.asset(
                      AppImages.image1,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Communicate with friends ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              SocialCubit.get(context).posts.length > 0
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => PostItem(
                            model: SocialCubit.get(context).posts[index], index: index,
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 5.0,
                          ),
                      itemCount: SocialCubit.get(context).posts.length)
                  : Center(child: CircularProgressIndicator()),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
