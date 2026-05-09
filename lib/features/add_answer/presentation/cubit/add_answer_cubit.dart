import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_answer_state.dart';

class AddAnswerCubit extends Cubit<AddAnswerState> {
  AddAnswerCubit() : super(AddAnswerInitial());
}
