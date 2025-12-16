import 'package:cr/calendar_bloc.dart';
import 'package:cr/fade_animated_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar_model.dart';
import 'calendar_type.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  // in case we want to control the scroll position
  late final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_scrollToBottom);

    return BlocConsumer<CalendarBloc, CalendarBlocState>(
      bloc: CalendarBloc(),
      builder: (context, state) {
        switch (state.selectedCalendarType) {
          case CalendarType.week:
            return _buildCalendarWeek(state);

          // not for a review
          case CalendarType.month:
          case CalendarType.day:
            throw UnimplementedError();
        }
      },
      listener: (context, state) {
        if (kDebugMode) print(state.toString());
      },
    );
  }

  Widget _buildCalendarWeek(CalendarBlocState state) {
    if (state.isSyncing) return Center(child: CircularProgressIndicator());

    final List<Widget> widgets = [_buildTitle(state), for (CalendarModel event in state.calendarEvents) Text(event.title)];

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(children: widgets),
    );
  }

  Widget _buildTitle(CalendarBlocState state) {
    return Text(state.selectedCalendarType.calendarTitle()).withAnimation();
  }

  void _scrollToBottom(Duration _) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
