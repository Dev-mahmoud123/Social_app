import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/chat_screen/chat_users_screen.dart';
import 'package:social_app/modules/home_screen/home_screen.dart';
import 'package:social_app/modules/post_screen/post_screen.dart';
import 'package:social_app/modules/settings_screen/settings_screen.dart';
import 'package:social_app/modules/user_screen/user_screen.dart';
import 'package:social_app/shared/bloc/cubit/social_cubit/social_cubit.dart';
import 'package:social_app/shared/bloc/state/bottom_nav_state/bottom_nav.dart';


class BottomNavCubit extends Cubit<BottomNavState> {

  BottomNavCubit() : super(BottomNavInitState());

static BottomNavCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;


  List<Widget> screens = [
    HomeScreen(),
    ChatUsersScreen(),
    PostScreen(),
    UserScreen(),
    SettingScreen(),
  ];

  List<String> title = ['Home', 'Chats', 'Post', 'Users', 'Settings'];


 void changeBottomNavIndex(int index , context){
   if(index == 1){
     SocialCubit.get(context).getAllUsers();
   }
   if(index == 2){
    emit(BottomNewPostState());
   }else{
     currentIndex = index;
     emit(BottomNavChangeState());
   }

 }


}
