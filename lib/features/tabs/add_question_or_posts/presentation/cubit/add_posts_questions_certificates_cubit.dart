import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_post_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_question_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/usecases/add_post_use_case.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/usecases/add_question_use_case.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_intents.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_side_effects.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddPostsQuestionsCertificatesCubit
    extends Cubit<AddPostsQuestionsCertificatesState> {
  final AddQuestionUseCase _addQuestionUseCase;
  final AddPostUseCase _addPostUseCase;

  final _sideEffectController =
      StreamController<AddPostsQuestionsCertificatesSideEffects>.broadcast();
  Stream<AddPostsQuestionsCertificatesSideEffects> get sideEffects =>
      _sideEffectController.stream;

  AddPostsQuestionsCertificatesCubit(
    this._addQuestionUseCase,
    this._addPostUseCase,
  ) : super(const AddPostsQuestionsCertificatesState());

  void doIntent(AddPostsQuestionsCertificatesIntents intent) {
    switch (intent) {
      case AddQuestionIntent(request: final request):
        _addQuestion(request);
      case AddPostIntent(request: final request):
        _addPost(request);
    }
  }

  void _addQuestion(AddQuestionRequestEntity request) async {
    _sideEffectController.add(ShowLoading());
    final result = await _addQuestionUseCase(request);
    result.when(
      success: (_) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(PopScreen());
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  void _addPost(AddPostRequestEntity request) async {
    _sideEffectController.add(ShowLoading());
    final result = await _addPostUseCase(request);
    result.when(
      success: (_) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(PopScreen());
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}
