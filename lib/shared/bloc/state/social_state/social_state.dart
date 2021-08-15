import 'package:social_app/models/message/message.dart';

abstract class SocialState {}

class SocialInitState extends SocialState {}

class SocialLoadingState extends SocialState {}


class SocialProfileImageSuccessState extends SocialState {}

class SocialProfileImageErrorState extends SocialState {}

class SocialCoverImageSuccessState extends SocialState {}

class SocialCoverImageErrorState extends SocialState {}

class SocialMessageImageSuccessState extends SocialState {}

class SocialMessageImageErrorState extends SocialState {}

// Upload profile image
class SocialUploadProfileImageSuccessState extends SocialState {}

class SocialUploadProfileImageErrorState extends SocialState {

}

// Upload cover image
class SocialUploadCoverImageSuccessState extends SocialState {}

class SocialUploadCoverImageErrorState extends SocialState {}

// Upload message image
class SocialUploadMessageImageSuccessState extends SocialState {}

class SocialUploadMessageImageErrorState extends SocialState {
  final String error;

  SocialUploadMessageImageErrorState(this.error);

}

class SocialUserUpdateErrorState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

// Create post
class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}

class SocialUploadPostImageSuccessState extends SocialState {}

class SocialUploadPostImageErrorState extends SocialState {}

class SocialPostImageSuccessState extends SocialState {}

class SocialPostImageErrorState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}

// Get posts
class SocialGetPostsSuccessState extends SocialState {}

class SocialGetPostsErrorState extends SocialState {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialState {}

class SocialLikePostsSuccessState extends SocialState{}

class SocialLikePostsErrorState extends SocialState{
  final String error;

  SocialLikePostsErrorState(this.error);
}
 /// Get all users
class SocialGetAllUsersSuccessState extends SocialState {}

class SocialGetAllUsersErrorState extends SocialState {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}


/// Send Message
class SocialSendMessageSuccessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {
  final String error;

  SocialSendMessageErrorState(this.error);
}

// get Message
class SocialGetMessageSuccessState extends SocialState {}
class SocialRemoveMessageImageState extends SocialState {}