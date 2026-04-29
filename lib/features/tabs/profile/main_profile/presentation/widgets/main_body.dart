import 'package:explaino/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_intents.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_state.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/action_buttons.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/header_section.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/point_card.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/profile_shimmer.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/stats_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBody extends StatelessWidget {
  const MainBody({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<MainProfileCubit, ProfileState>(
      builder: (context, state) {
        final baseState = state.profileBaseState;

        if (baseState == null) return const SizedBox.shrink();

        if (baseState.isFetching && baseState.data == null) {
          return const ProfileShimmer();
        }

        if (baseState.errorMessage != null) {
          return Center(
            child: CustomErrorWidget(
              error: baseState.errorMessage!,
              onTryAgain: () {
                context.read<MainProfileCubit>().onIntent(
                  GetProfileDataIntent(),
                );
              },
            ),
          );
        }

        final user = baseState.data;
        final fullName = '${user?.firstName ?? ''} ${user?.lastName ?? ''}'
            .trim();
        final specialization = (user?.specializations.isNotEmpty ?? false)
            ? user!.specializations.first.name
            : 'No Specialization';

        return Column(
          children: [
            HeaderSection(
              name: fullName,
              specialization: specialization,
              imageUrl: user?.profilePicture,
            ),
            SizedBox(height: size.height * 0.03),
            const ActionButtons(),
            SizedBox(height: size.height * 0.040),
            PointCard(points: user?.wallet.balance),
            SizedBox(height: size.height * 0.015),
            const StatsRow(),
            SizedBox(height: size.height * 0.01),
          ],
        );
      },
    );
  }
}
