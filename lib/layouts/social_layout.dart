import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/resuable_components.dart';
import 'package:social_app/modules/post_screen/post_screen.dart';
import 'package:social_app/shared/bloc/cubit/bottom_nav_cubit/bottom_nav.dart';
import 'package:social_app/shared/bloc/state/bottom_nav_state/bottom_nav.dart';
import 'package:social_app/style/icons/app_icons.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocConsumer<BottomNavCubit, BottomNavState>(
          listener: (context, state) {
            if(state is BottomNewPostState){
              navigateTo(context: context , widget: PostScreen());
            }
          },
          builder: (context, state) {
            BottomNavCubit cubit = BottomNavCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                title: Text(
                  cubit.title[cubit.currentIndex],
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black),
                ),
                elevation: 0.0,
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none),
                    color: Colors.black54,
                    iconSize: 27.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    color: Colors.black54,
                    iconSize: 27.0,
                  ),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                elevation: 10.0,
                selectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavIndex(index , context);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        AppIcons.chat,
                        height: 25,
                      ),
                      label: 'Chat'),
                  BottomNavigationBarItem(
                      icon: InkWell(
                        child: Icon(Icons.add_circle_outline),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PostScreen()));
                        },
                      ),
                      label: 'Post'),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        AppIcons.users,
                        color: Colors.black87,
                        height: 25,
                      ),
                      label: 'Users'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ],
              ),
            );
          }),
    );
  }
}
