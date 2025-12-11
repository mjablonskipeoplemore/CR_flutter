part of 'calendar_bloc.dart';

class CalendarBlocState {
  CalendarBlocState({
    required this.selectedDate,
    required this.selectedCalendarType,
    required this.events,
    required this.isSyncing,
  });

  factory CalendarBlocState.initial() => CalendarBlocState(
    selectedDate: DateTime.now(),
    selectedCalendarType: CalendarType.month,
    events: [],
    isSyncing: false,
  );

  final DateTime selectedDate;
  final CalendarType selectedCalendarType;
  final List<CalendarEvent> events;
  final bool isSyncing;

  CalendarBlocState copyWith({
    DateTime? selectedDate,
    CalendarType? selectedCalendarType,
    List<CalendarEvent>? events,
    bool? isSyncing,
  }) => CalendarBlocState(
    selectedDate: selectedDate ?? this.selectedDate,
    selectedCalendarType: selectedCalendarType ?? this.selectedCalendarType,
    events: events ?? this.events,
    isSyncing: isSyncing ?? this.isSyncing,
  );

  @override
  String toString() {
    String eventsString = "";
    for (CalendarEvent event in events) {
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
  final CalendarEvent event;

  AddCalendarEventEvent({required this.event});
}
