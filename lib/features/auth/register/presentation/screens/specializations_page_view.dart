import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:explaino/features/auth/register/presentation/widgets/specialization_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecializationsPageView extends StatefulWidget {
  const SpecializationsPageView({super.key});

  @override
  State<SpecializationsPageView> createState() =>
      _SpecializationsPageViewState();
}

class _SpecializationsPageViewState extends State<SpecializationsPageView> {
  late TextTheme textTheme;
  late Size screenSize;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.of(context).size;
  }

  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().doIntent(GetSpecializationsIntent());
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
            buildWhen: (previous, current) =>
                previous.specializations != current.specializations ||
                previous.selectedSpecializations !=
                    current.selectedSpecializations,
            builder: (context, state) {
              if (state.specializations?.errorMessage != null) {
                return SizedBox(
                  height: screenSize.height * 0.6,
                  child: CustomErrorWidget(
                    error: state.specializations!.errorMessage!,
                    onTryAgain: () {
                      context.read<RegisterCubit>().doIntent(
                        GetSpecializationsIntent(),
                      );
                    },
                  ),
                );
              }
              if (state.specializations?.data == null) {
                return const SizedBox.shrink();
              }
              final specializations = state.specializations!.data!;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 185 / 138,
                ),
                itemCount: specializations.count,
                itemBuilder: (context, index) {
                  return SpecializationCard(
                    isSelected: state.selectedSpecializations.contains(
                      specializations.specializations[index].id,
                    ),
                    specialization: specializations.specializations[index],
                    onTap: () {
                      context.read<RegisterCubit>().doIntent(
                        ClickOnSpecializationIntent(
                          specializationId:
                              specializations.specializations[index].id,
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: screenSize.height * 0.07,
            child: BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) =>
                  previous.selectedSpecializations !=
                  current.selectedSpecializations,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.selectedSpecializations.isEmpty
                      ? null
                      : () {
                          context.read<RegisterCubit>().doIntent(
                            SelectSpecializationsIntent(),
                          );
                        },
                  child: const Text(AppTextConstants.next),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
