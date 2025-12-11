import 'dart:async';

import 'package:cr/calendar_api.dart';
import 'package:cr/calendar_event.dart';
import 'package:cr/calendar_repository.dart';
import 'package:cr/calendar_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_bloc_state_event.dart';

class CalendarBloc extends Bloc<CalendarBlocEvent, CalendarBlocState> {
  CalendarBloc() : super(CalendarBlocState.initial()) {
    on<GetCalendarEvent>(_onGetCalendarEvent);
    on<SelectCalendarTypeEvent>((event, emit) {
      emit(state.copyWith(selectedCalendarType: event.calendarType));
    });
    on<AddCalendarEventEvent>(_onAddCalendarEventEvent);
  }

  final CalendarRepository _calendarRepository = CalendarRepository(CalendarApi());

  FutureOr<void> _onGetCalendarEvent(GetCalendarEvent event, Emitter<CalendarBlocState> emit) async {
    emit(state.copyWith(isSyncing: true));
    _updateEvents(emit);
  }

  FutureOr<void> _onAddCalendarEventEvent(AddCalendarEventEvent event, Emitter<CalendarBlocState> emit) async {
    emit(state.copyWith(isSyncing: true));

    await _calendarRepository.addCalendarEvent(event.event);
    _updateEvents(emit);
  }

  void _updateEvents(Emitter<CalendarBlocState> emit) async {
    final List<CalendarEvent> events = await _calendarRepository.getCalendarEvents();

    emit(state.copyWith(events: events, isSyncing: false));
  }
}
