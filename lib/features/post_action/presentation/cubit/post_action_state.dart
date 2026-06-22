import 'package:equatable/equatable.dart';
import 'package:explaino/features/post_action/domain/entities/response/post_entity.dart';

class PostActionState extends Equatable {
  final PostEntity? post;
  const PostActionState({this.post});

  PostActionState copyWith({PostEntity? post}) =>
      PostActionState(post: post ?? this.post);

  @override
  List<Object?> get props => [post];
}
