import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:explaino/features/auth/register/presentation/widgets/track_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TracksPageView extends StatefulWidget {
  const TracksPageView({super.key});

  @override
  State<TracksPageView> createState() => _TracksPageViewState();
}

class _TracksPageViewState extends State<TracksPageView> {
  late TextTheme textTheme;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().doIntent(GetTracksIntent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.07),
          Text(
            AppTextConstants.selectYourTrack,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppTextConstants.selectYourTrackDescription,
            style: textTheme.bodyLarge?.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: 28),
          BlocBuilder<RegisterCubit, RegisterState>(
            buildWhen: (previous, current) => previous.tracks != current.tracks,
            builder: (context, state) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 185 / 128,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TrackCard(isSelected: false, onTap: () {});
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
