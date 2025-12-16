part of 'calendar_bloc.dart';

class CalendarBlocState {
  CalendarBlocState({
    required this.selectedDate,
    required this.selectedCalendarType,
    required this.calendarEvents,
    required this.isSyncing,
  });

  factory CalendarBlocState.initial() => CalendarBlocState(
    selectedDate: DateTime.now(),
    selectedCalendarType: CalendarType.month,
    calendarEvents: [],
    isSyncing: false,
  );

  final DateTime selectedDate;
  final CalendarType selectedCalendarType;
  final List<CalendarModel> calendarEvents;
  final bool isSyncing;

  CalendarBlocState copyWith({
    DateTime? selectedDate,
    CalendarType? selectedCalendarType,
    List<CalendarModel>? calendarEvents,
    bool? isSyncing,
  }) => CalendarBlocState(
    selectedDate: selectedDate ?? this.selectedDate,
    selectedCalendarType: selectedCalendarType ?? this.selectedCalendarType,
    calendarEvents: calendarEvents ?? this.calendarEvents,
    isSyncing: isSyncing ?? this.isSyncing,
  );

  @override
  String toString() {
    String eventsString = "";
    for (CalendarModel event in calendarEvents) {
      eventsString += "$event, ";
    }
    return 'CalendarBlocState(selectedDate: $selectedDate, selectedCalendarType: '
        '$selectedCalendarType, events: [$eventsString], isSyncing: $isSyncing)';
  }
}

sealed class CalendarBlocEvent {}

class GetCalendarEvent extends CalendarBlocEvent {
  final DateTime startDate;
  final int days;

  GetCalendarEvent({required this.startDate, required this.days});
}

class SelectCalendarTypeEvent extends CalendarBlocEvent {
  final CalendarType calendarType;

  SelectCalendarTypeEvent({required this.calendarType});
}

class AddCalendarEventEvent extends CalendarBlocEvent {
  final CalendarModel event;

  AddCalendarEventEvent({required this.event});
}
