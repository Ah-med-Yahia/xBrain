class ApiConstants {
  ApiConstants._();
  //====================Headers============================
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  //====================Keys============================
  static const String refreshTokenKey = 'refresh';
  //==================== Base URL============================
  static const String baseUrl =
      'https://xbrain-backend-chbfe7hscpbqergn.francecentral-01.azurewebsites.net/api/';
  //==================== Public Endpoints============================
  static const List<String> publicEndpoints = [
    ApiConstants.login,
    ApiConstants.register,
    ApiConstants.forgotPassword,
    ApiConstants.resetPassword,
    ApiConstants.verifyEmail,
    ApiConstants.refreshToken,
    ApiConstants.resendOtp,
    ApiConstants.verifyResetOtp,
  ];
  //==================== Auth============================
  static const String login = 'auth/login/';
  static const String register = 'auth/register/';
  static const String forgotPassword = 'auth/forgot-password/';
  static const String resetPassword = 'auth/reset-password/';
  static const String verifyEmail = 'auth/verify-email/';
  static const String refreshToken = 'auth/token/refresh/';
  static const String resendOtp = 'auth/resend-otp/';
  static const String verifyResetOtp = 'auth/verify-reset-otp/';
  //==================== Profile============================
  static const String updateProfile = 'users/me/';
  static const String getCertificate = 'users/me/certificates/';
  static const String addCertificate = 'users/me/certificates/';
  static const String deleteCertificate = 'users/me/certificates/{id}/';
  //==================== Specializations============================
  static const String specializations = 'specializations/';
  static const String selectSpecializations = 'users/me/specializations/';
  static const String getProfile = 'users/me/';
  //==========================================================
  //==================== Questions ============================
  //==========================================================
  //==================== Get Questions ============================
  static const String getQuestionList =
      'questions/'; // home tab  {_,GetListQuestionsResponseModel}
  static const String getFirstTenAnswersOfQuestion =
      'questions/{id}/'; // when tab on a question  {_,FirstTenAnswerOfQuestionResponsModel}
  //==================== Add Question ============================
  static const String addQuestion =
      'questions/'; // when add a question {AddQuestionRequestModel,AddQuestionResponseModel}
  //==================== Update Questions ============================
  static const String resolveQuestion =
      'questions/{id}/resolve/'; // {_,FirstTenAnswerOfQuestionResponsModel}
  static const String unresolveQuestion =
      'questions/{id}/unresolve/'; // {_,FirstTenAnswerOfQuestionResponsModel}
  static const String updateQuestion =
      'questions/{id}/'; // {AddQuestionRequestModel,AddQuestionResponseModel}
  //==================== Delete Question ============================
  static const String deleteQuestion = 'questions/{id}/'; // {_,}
  //==========================================================
  //==================== Answers ============================
  //==========================================================
  //==================== Add Answer ==========================
  static const String addAnswer =
      'questions/{question_id}/answers/'; // {AddAnswerRequestModel,AnswerModel}
  static const String addReply =
      'answers/{id}/replies/'; // when add a reply {AddAnswerRequestModel,AnswerModel}
  //==================== Get Answers ============================
  static const String getAllAnswers =
      'questions/{question_id}/answers/'; // when get All answers {_,AnswersOfQuestionResponsModel}
  static const String getReplies =
      'answers/{id}/replies/'; // when get all replies {_,AnswersOfQuestionResponsModel}
  static const String getSingleAnswerOrReply =
      'answers/{id}/'; // {_,AnswerModel}
  //==================== Update Answers ============================
  static const String updateAnswer =
      'answers/{id}/'; // {AddAnswerRequestModel,AnswerModel}
  //==================== Delete Answers ============================
  static const String deleteAnswer = 'answers/{id}/'; // {_,_}
  //============================================================
  //==================== Attachments =========================
  static const String deleteAttachment = 'attachments/{id}/'; // {_,}
  //==========================================================
  //==================== Posts =========================
  //==================== Add Post ==========================
  static const String addPost = 'posts/'; // {AddPostRequestModel,PostModel}
  //==================== Get Posts ==========================
  static const String getPosts = 'posts/'; // {_,GetPostsResponseModel}
  static const String getSinglePost = 'posts/{id}/'; // {_,PostModel}
  //==================== Update Post ==========================
  static const String updatePost =
      'posts/{id}/'; // {AddPostRequestModel,PostModel}
  static const String likePost = 'posts/{id}/like/'; // {_,PostModel}
  static const String unlikePost = 'posts/{id}/dislike/'; // {_,PostModel}
  //==================== Delete Post ==========================
  static const String deletePost = 'posts/{id}/'; // {_,_}
  //==========================================================
  //==================== Comments ============================
  //==========================================================
  //==================== Get Comments ==========================
  static const String getComments =
      'posts/{id}/comments/'; // {_,GetCommentsOfPostResponseModel}
  static const String getRepliesOnComment =
      'comments/{id}/replies/'; // {_,GetCommentsOfPostResponseModel }
  static const String getSingleCommentOrReply =
      'comments/{id}/'; // {_,CommentModel}
  //==================== Add Comment ==========================
  static const String addComment =
      'posts/{id}/comments/'; // {String {content},CommentModel}
  static const String addReplyOnComment =
      'comments/{id}/replies/'; // {String {content},CommentModel}
  //==================== Delete CommentOrReply ==========================
  static const String deleteCommentOrReply = 'comments/{id}/'; // {_,_}
  //==================== Update CommentOrReply ==========================
  static const String updateCommentOrReply =
      'comments/{id}/'; // {String {content},CommentModel}
}
