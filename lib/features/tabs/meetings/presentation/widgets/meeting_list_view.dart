import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/card_shimmer.dart';
import 'package:flutter/material.dart';

class MeetingsListView<T> extends StatelessWidget {
  const MeetingsListView({
    super.key,
    required this.state,
    required this.items,
    required this.itemBuilder,
    required this.onRetry,
    required this.scrollController,
  });

  final BaseState<dynamic> state;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final VoidCallback onRetry;
  final ScrollController scrollController;

  static const int _shimmerItemCount = 6;

  bool get _isInitialLoad => items.isEmpty && state.errorMessage == null;

  @override
  Widget build(BuildContext context) {
    if (state.errorMessage != null) {
      return Center(
        child: CustomErrorWidget(
          error: state.errorMessage!,
          onTryAgain: onRetry,
        ),
      );
    }

    if (_isInitialLoad) {
      return ListView.builder(
        itemCount: _shimmerItemCount + 1,
        itemBuilder: (_, index) {
          return const CardShimmer();
        },
      );
    }

    final bool isLoadingMore = state.isFetching;

    return ListView.builder(
      controller: scrollController,
      itemCount: items.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (_, index) {
        final itemIndex = index;

        if (itemIndex == items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return itemBuilder(items[itemIndex]);
      },
    );
  }
}
