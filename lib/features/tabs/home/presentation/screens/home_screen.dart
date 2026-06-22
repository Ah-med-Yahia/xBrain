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
  final ScrollController _questionsScrollController = ScrollController();
  final ScrollController _postsScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>()..doIntent(GetQuestionListIntent());
    _questionsScrollController.addListener(() {
      if (_questionsScrollController.position.pixels >=
          _questionsScrollController.position.maxScrollExtent - 200) {
        _homeCubit.doIntent(GetQuestionListIntent());
      }
    });

    _postsScrollController.addListener(() {
      if (_postsScrollController.position.pixels >=
          _postsScrollController.position.maxScrollExtent - 200) {
        _homeCubit.doIntent(GetPostsListIntent());
      }
    });
  }

  @override
  void dispose() {
    _questionsScrollController.dispose();
    _postsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _homeCubit,
      child: ColoredBox(
        color: AppColors.kLight,
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (prev, next) =>
              prev.questionTapActive != next.questionTapActive,
          builder: (context, state) {
            return state.questionTapActive
                ? _buildQuestionsList()
                : _buildPostsList();
          },
        ),
      ),
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
        onRefresh: () async {
          context.read<HomeCubit>().doIntent(RefreshQuestionsIntent());
          await Future.doWhile(() async {
            await Future.delayed(const Duration(milliseconds: 100));
            return _homeCubit.state.questionsState.isFetching;
          });
        },
        itemBuilder: (question) => QuestionCard(question: question),
        scrollController: _questionsScrollController,
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
        onRefresh: () async {
          context.read<HomeCubit>().doIntent(RefreshPostsIntent());
          await Future.doWhile(() async {
            await Future.delayed(const Duration(milliseconds: 100));
            return _homeCubit.state.postsState.isFetching;
          });
        },
        itemBuilder: (post) => PostCard(shortPost: post),
        scrollController: _postsScrollController,
      ),
    );
  }

  Widget _buildListContent<T>({
    required BaseState<dynamic> state,
    required List<T> items,
    required Widget Function(T item) itemBuilder,
    required VoidCallback onRetry,
    required VoidCallback onRefresh,
    required ScrollController scrollController,
  }) {
    if (items.isEmpty && state.errorMessage == null) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: 7,
        itemBuilder: (_, index) {
          if (index == 0) return _buildTabBar();
          return const CardShimmer();
        },
      );
    }

    if (state.errorMessage != null) {
      return Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: Center(
              child: CustomErrorWidget(
                error: state.errorMessage!,
                onTryAgain: onRetry,
              ),
            ),
          ),
        ],
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      elevation: 0,
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: items.length + 1 + (state.isFetching ? 1 : 0),
        itemBuilder: (_, index) {
          if (index == 0) return _buildTabBar();
          final itemIndex = index - 1;
          if (itemIndex == items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return itemBuilder(items[itemIndex]);
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, next) =>
          prev.questionTapActive != next.questionTapActive,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 10),
        child: HomeTabBar(
          selectedIndex: state.questionTapActive ? 0 : 1,
          onTabChanged: (int value) {
            context.read<HomeCubit>().doIntent(
              TabChangedIntent(isQuestion: value == 0),
            );
          },
        ),
      ),
    );
  }
}
