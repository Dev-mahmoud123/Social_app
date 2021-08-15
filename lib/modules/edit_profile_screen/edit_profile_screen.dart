import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/resuable_components.dart';
import 'package:social_app/shared/bloc/cubit/social_cubit/social_cubit.dart';
import 'package:social_app/shared/bloc/state/social_state/social_state.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var userModel = SocialCubit
            .get(context)
            .userModel;
        var profileImage = SocialCubit
            .get(context)
            .profileImage;
        var coverImage = SocialCubit
            .get(context)
            .coverImage;
        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: TextStyle(color: Colors.black),
            ),
            titleSpacing: 0.0,
            backgroundColor: Theme
                .of(context)
                .scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              defaultTextButton(
                press: () {
                  SocialCubit.get(context).userUpdate(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,);
                },
                text: 'Update',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column( 
              children: [
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0)),
                                image: DecorationImage(
                                  image: coverImage == null
                                      ? NetworkImage(
                                    '${userModel.cover}',
                                  )
                                      : FileImage(coverImage),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white24,
                              radius: 20.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).selectCoverImage();
                                  },
                                  icon: Icon(Icons.camera_alt),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                            Theme
                                .of(context)
                                .scaffoldBackgroundColor,
                            radius: 53.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(
                                '${userModel.profileImage}',
                              )
                                  : FileImage(profileImage),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white24,
                            radius: 20.0,
                            child: IconButton(
                              onPressed: () {
                                SocialCubit.get(context).selectProfileImage();
                              },
                              icon: Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if(profileImage != null || coverImage != null)
                  Row(
                    children: [
                      if(profileImage != null)
                        Expanded(
                          child: defaultTextButton(press: () {
                            SocialCubit.get(context).upLoadProfileImage(
                              name: nameController.text,
                              bio: bioController.text,
                              phone: phoneController.text,);
                          }, text: 'Update Profile'),
                        ),
                      if(coverImage != null) 
                        Expanded(
                          child: defaultTextButton(press: () {
                            SocialCubit.get(context).upLoadProfileImage(
                              name: nameController.text,
                              bio: bioController.text,
                              phone: phoneController.text,);
                          }, text: 'Update Cover'),
                        ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      defaultTextField(
                          label: 'Name',
                          type: TextInputType.text,
                          prefixIcon: Icon(Icons.person),
                          controller: nameController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultTextField(
                          label: 'bio',
                          type: TextInputType.text,
                          prefixIcon: Icon(Icons.info),
                          controller: bioController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'bio must not be empty';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultTextField(
                          label: 'phone',
                          type: TextInputType.phone,
                          prefixIcon: Icon(Icons.phone),
                          controller: phoneController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Phone number must not be empty';
                            }
                            return null;
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
