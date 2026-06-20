import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_action_state.dart';

class PostActionCubit extends Cubit<PostActionState> {
  PostActionCubit() : super(PostActionInitial());
}
