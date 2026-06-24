import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_shimmer.dart';
import 'package:flutter/material.dart';

class MeetingsListView<T> extends StatelessWidget {
  const MeetingsListView({
    super.key,
    required this.state,
    required this.items,
    required this.itemBuilder,
    required this.onRetry,
    required this.onRefresh,
    required this.scrollController,
  });

  final BaseState<dynamic> state;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final VoidCallback onRetry;
  final VoidCallback onRefresh;
  final ScrollController scrollController;
  static const int _shimmerItemCount = 6;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && state.errorMessage == null) {
      return ListView.builder(
        itemCount: _shimmerItemCount + 1,
        itemBuilder: (_, index) {
          return const MeetingCardShimmer();
        },
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

    if (!state.isFetching && items.isEmpty && state.data != null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppTextConstants.noMeetingsYet,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.jetBlack,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final bool isLoadingMore = state.isFetching;
    return RefreshIndicator(
      color: AppColors.primary,
      elevation: 0,
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      onRefresh: () async {
        onRefresh();
        await Future.doWhile(() async {
          await Future.delayed(const Duration(milliseconds: 100));
          return state.isFetching;
        });
      },
      child: ListView.builder(
        controller: scrollController,
        itemCount: items.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (_, index) {
          final itemIndex = index;
          if (itemIndex == items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }
          return itemBuilder(items[itemIndex]);
        },
      ),
    );
  }
}
