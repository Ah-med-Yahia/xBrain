import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_cubit.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_intents.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_side_effects.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_state.dart';
import 'package:explaino/features/tabs/meetings/presentation/screens/meeting_confirmed_screen.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_list_view.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  late final MeetingsCubit _meetingsCubit;
  final ScrollController _incomingScrollController = ScrollController();
  final ScrollController _outgoingScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _meetingsCubit = getIt<MeetingsCubit>();
    _meetingsCubit.doIntent(GetIncomingMeetingsIntent());
    _meetingsCubit.sideEffects.listen((effect) {
      if (!mounted) return;
      switch (effect) {
        case ShowError():
          _handelError(effect.message);
        case ShowLoading():
          _handelLoading();
        case HideLoading():
          _handelHideLoading();
        case ShowSuccessMessage():
          _handelSuccess(effect.message);
        case NavigateToMeetingConfirmed():
          _handleNavigateToMeetingConfirmed(effect.meeting);
      }
    });
    _incomingScrollController.addListener(() {
      if (_incomingScrollController.position.pixels >=
          _incomingScrollController.position.maxScrollExtent - 200) {
        _meetingsCubit.doIntent(GetIncomingMeetingsIntent());
      }
    });

    _outgoingScrollController.addListener(() {
      if (_outgoingScrollController.position.pixels >=
          _outgoingScrollController.position.maxScrollExtent - 200) {
        _meetingsCubit.doIntent(GetOutgoingMeetingsIntent());
      }
    });
  }

  void _handelLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UIUtils.showEasyLoading();
    });
  }

  void _handelError(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.error,
      textColor: AppColors.white,
    );
  }

  void _handelHideLoading() {
    UIUtils.hideEasyLoading();
  }

  void _handelSuccess(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.green,
      textColor: AppColors.white,
    );
  }

  void _handleNavigateToMeetingConfirmed(
    ScheduleMeetingResponseEntity meeting,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeetingConfirmedScreen(meeting: meeting),
      ),
    );
  }

  @override
  void dispose() {
    _incomingScrollController.dispose();
    _outgoingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _meetingsCubit,
      child: ColoredBox(
        color: AppColors.kLight,
        child: Column(
          children: [
            const SizedBox(height: 30),
            const MeetingTabSelector(),
            Expanded(
              child: BlocBuilder<MeetingsCubit, MeetingsState>(
                buildWhen: (prev, next) =>
                    prev.incomingSelected != next.incomingSelected,
                builder: (context, state) {
                  return state.incomingSelected
                      ? _buildIncomingMeetingsList()
                      : _buildOutgoingMeetingsList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomingMeetingsList() {
    return BlocBuilder<MeetingsCubit, MeetingsState>(
      buildWhen: (prev, next) =>
          prev.getIncomingMeetingsState.data?.results !=
          next.getIncomingMeetingsState.data?.results,
      builder: (context, state) =>
          MeetingsListView<ScheduleMeetingResponseEntity>(
            state: state.getIncomingMeetingsState,
            items: state.getIncomingMeetingsState.data?.results ?? [],
            onRetry: () => _meetingsCubit.doIntent(GetIncomingMeetingsIntent()),
            onRefresh: () =>
                _meetingsCubit.doIntent(RefreshIncomingMeetingsIntent()),
            itemBuilder: (meeting) => MeetingCard(
              meeting: meeting,
              namingList: AppTextConstants.incoming.toLowerCase(),
            ),
            scrollController: _incomingScrollController,
          ),
    );
  }

  Widget _buildOutgoingMeetingsList() {
    return BlocBuilder<MeetingsCubit, MeetingsState>(
      buildWhen: (prev, next) =>
          prev.getOutgoingMeetingsState != next.getOutgoingMeetingsState,
      builder: (context, state) =>
          MeetingsListView<ScheduleMeetingResponseEntity>(
            state: state.getOutgoingMeetingsState,
            items: state.getOutgoingMeetingsState.data?.results ?? [],
            onRetry: () => _meetingsCubit.doIntent(GetOutgoingMeetingsIntent()),
            onRefresh: () =>
                _meetingsCubit.doIntent(RefreshOutGoingMeetingsIntent()),
            itemBuilder: (meeting) => MeetingCard(
              meeting: meeting,
              namingList: AppTextConstants.outgoing.toLowerCase(),
            ),
            scrollController: _outgoingScrollController,
          ),
    );
  }
}
