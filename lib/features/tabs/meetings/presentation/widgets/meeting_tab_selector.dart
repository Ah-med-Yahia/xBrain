import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_cubit.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_intents.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetingTabSelector extends StatelessWidget {
  const MeetingTabSelector({super.key});

  static const Duration _animationDuration = Duration(milliseconds: 250);
  static const Curve _animationCurve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingsCubit, MeetingsState>(
      builder: (context, state) {
        final selectedIndex = state.incomingSelected ? 0 : 1;
        return Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 20,
            right: 20,
            bottom: 8,
          ),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tabWidth = constraints.maxWidth / 2;
                return Stack(
                  children: [
                    AnimatedAlign(
                      duration: _animationDuration,
                      curve: _animationCurve,
                      alignment: selectedIndex == 0
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: tabWidth,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _MeetingTab(
                          label: AppTextConstants.incoming,
                          isSelected: selectedIndex == 0,
                          animationDuration: _animationDuration,
                          onTap: () {
                            context.read<MeetingsCubit>().doIntent(
                              IncomingMeetingsChangedIntent(
                                incomingSelected: true,
                              ),
                            );
                          },
                        ),
                        _MeetingTab(
                          label: AppTextConstants.outgoing,
                          isSelected: selectedIndex == 1,
                          animationDuration: _animationDuration,
                          onTap: () {
                            context.read<MeetingsCubit>().doIntent(
                              IncomingMeetingsChangedIntent(
                                incomingSelected: false,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _MeetingTab extends StatelessWidget {
  const _MeetingTab({
    required this.label,
    required this.isSelected,
    required this.animationDuration,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Duration animationDuration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: double.infinity,
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: animationDuration,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
