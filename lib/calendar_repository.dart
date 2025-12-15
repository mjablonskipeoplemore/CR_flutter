import 'dart:async';

import 'package:cr/calendar_model.dart';

import 'calendar_api.dart';

class CalendarRepository {
  CalendarRepository(this._calendarApi);

  final CalendarApi _calendarApi;
  final List<CalendarModel> _remoteEventsCached = [];
  final List<CalendarModel> _pendingEvents = [];

  Completer<void>? _syncCompleter;

  late final Timer timer = Timer.periodic(const Duration(milliseconds: 50), _onTimerTick);

  Future<List<CalendarModel>> getCalendarEvents() async {
    // Simulate some data processing
    await Future<void>.delayed(const Duration(milliseconds: 700));

    await _syncCompleter?.future;
    _syncCompleter = Completer.sync();

    try {
      final List<CalendarModel> events = await _calendarApi.getFakeEvents();
      _remoteEventsCached.addAll(events);

      return events;
      // fallback to cached events in case of error
    } catch (e) {
      return _remoteEventsCached;
    } finally {
      _syncCompleter?.complete();
    }
  }

  Future<void> addCalendarEvent(CalendarModel event) async {
    await _syncCompleter?.future;
    _syncCompleter = Completer.sync();

    _pendingEvents.add(event);
    _remoteEventsCached.add(event);
    try {
      await _calendarApi.addFakeEvents(_pendingEvents);
    } finally {
      _syncCompleter?.complete();
    }
  }

  Future<void> _onTimerTick(Timer timer) async {
    await getCalendarEvents();
  }
}
