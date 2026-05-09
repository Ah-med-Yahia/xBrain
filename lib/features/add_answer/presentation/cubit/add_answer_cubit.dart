import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_answer_state.dart';

class AddAnswerCubit extends Cubit<AddAnswerState> {
  AddAnswerCubit() : super(AddAnswerInitial());
}
