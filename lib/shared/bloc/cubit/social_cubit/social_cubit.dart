import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/components/resuable_components.dart';
import 'package:social_app/models/message/message.dart';
import 'package:social_app/models/posts/user_post.dart';
import 'package:social_app/models/user/user.dart';
import 'package:social_app/shared/bloc/state/social_state/social_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  void getUserData() {
    emit(SocialLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  ImagePicker picker = ImagePicker();
  File profileImage;
  File coverImage;
  File postImage;
  File messageImage;

  void selectProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImageErrorState());
    }
  }

  void selectCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImageErrorState());
    }
  }

  void selectPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImageErrorState());
    }
  }

  void selectMessageImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      emit(SocialMessageImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialMessageImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void removeMessageImage() {
    messageImage = null;
    emit(SocialRemoveMessageImageState());
  }

  void upLoadProfileImage({
    @required name,
    @required bio,
    @required phone,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then(
        (value) {
          userUpdate(
            name: name,
            bio: bio,
            phone: phone,
            profile: value,
          );
          emit(SocialUploadProfileImageSuccessState());
        },
      ).catchError(
        (error) {
          emit(SocialUploadProfileImageErrorState());
        },
      );
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void upLoadCoverImage({
    @required name,
    @required bio,
    @required phone,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then(
        (value) {
          userUpdate(
            name: name,
            bio: bio,
            phone: phone,
            cover: value,
          );
          emit(SocialUploadCoverImageSuccessState());
        },
      ).catchError(
        (error) {
          emit(SocialUploadCoverImageErrorState());
        },
      );
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void upLoadMessageImage({
    @required receiverId,
    @required text,
    @required dateTime,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('message/${Uri.file(messageImage.path).pathSegments.last}')
        .putFile(messageImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
            receiverId: receiverId,
            text: text,
            dateTime: dateTime,
            messageImage: value);
      }).catchError((error) {
        emit(SocialUploadMessageImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialUploadMessageImageErrorState(error.toString()));
    });
  }

  void userUpdate(
      {@required name,
      @required bio,
      @required phone,
      String cover,
      String profile}) {
    UserModel model = UserModel(
      name: name,
      bio: bio,
      phone: phone,
      uid: userModel.uid,
      email: userModel.email,
      cover: cover ?? userModel.cover,
      profileImage: profile ?? userModel.profileImage,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uid)
        .update(model.toJson())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  void upLoadPostImage({
    @required text,
    @required dateTime,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then(
        (value) {
          print(value);
          createPost(text: text, dateTime: dateTime, postImage: value);
        },
      ).catchError(
        (error) {
          emit(SocialUploadPostImageErrorState());
        },
      );
    }).catchError((error) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createPost({
    @required String text,
    @required String dateTime,
    String postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
      profileImage: userModel.profileImage,
      uid: userModel.uid,
      name: userModel.name,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toJson())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
        emit(SocialGetPostsSuccessState());
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uid)
        .set({'like': true}).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel.uid)
            users.add(UserModel.fromJson(element.data()));
          emit(SocialGetAllUsersSuccessState());
        });
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({
    @required receiverId,
    @required text,
    @required dateTime,
    String messageImage,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      senderId: userModel.uid,
      dateTime: dateTime,
      text: text,
      image: messageImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toJson())
        .then((value) {
          removeMessageImage();
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uid)
        .collection('message')
        .add(model.toJson())
        .then((value) {
          removeMessageImage();
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessage({@required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
