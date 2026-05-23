import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/home/presentation/cubit/home_cubit.dart';
import 'package:explaino/features/tabs/home/presentation/cubit/home_intents.dart';
import 'package:explaino/features/tabs/home/presentation/cubit/home_state.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/card_shimmer.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/home_tap_bar.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/question_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>()..doIntent(GetQuestionListIntent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _homeCubit,
      child: ColoredBox(
        color: AppColors.kLight,
        child: NestedScrollView(
          headerSliverBuilder: (_, _) => [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 12, bottom: 10),
                child: HomeTabBar(),
              ),
            ),
          ],
          body: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (prev, next) =>
                prev.questionTapActive != next.questionTapActive,
            builder: (context, state) {
              return state.questionTapActive
                  ? _buildQuestionsList()
                  : _buildPostsList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListContent<T>({
    required BaseState<dynamic> state,
    required List<T> items,
    required Widget Function(T item) itemBuilder,
    required VoidCallback onRetry,
  }) {
    if (state.isFetching && items.isEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: 6,
        itemBuilder: (_, _) => const CardShimmer(),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: CustomErrorWidget(
          error: state.errorMessage!,
          onTryAgain: onRetry,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount: items.length,
      itemBuilder: (_, index) => itemBuilder(items[index]),
    );
  }

  Widget _buildQuestionsList() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, next) => prev.questionsState != next.questionsState,
      builder: (context, state) => _buildListContent(
        state: state.questionsState,
        items: state.questionsState.data?.questions ?? [],
        onRetry: () =>
            context.read<HomeCubit>().doIntent(GetQuestionListIntent()),
        itemBuilder: (question) => QuestionCard(question: question),
      ),
    );
  }

  Widget _buildPostsList() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, next) => prev.postsState != next.postsState,
      builder: (context, state) => _buildListContent(
        state: state.postsState,
        items: state.postsState.data?.posts ?? [],
        onRetry: () => context.read<HomeCubit>().doIntent(GetPostsListIntent()),
        itemBuilder: (post) => PostCard(post: post),
      ),
    );
  }
}
