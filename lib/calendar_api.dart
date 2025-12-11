import 'dart:math';

import 'calendar_event.dart';

class CalendarApi {
  //not for a review
  Future<List<CalendarEvent>> getFakeEvents() async {
    await Future.delayed(Duration(milliseconds: Random().nextInt(500) + 500));

    return List.generate(Random().nextInt(50), (index) {
      final randomStartTime = DateTime(2025, 1, 1, Random().nextInt(24), Random().nextInt(60));
      final randomEndTime = randomStartTime.add(Duration(hours: Random().nextInt(3)));

      return CalendarEvent(
        title: 'index: $index',
        startTime: randomStartTime,
        endTime: randomEndTime,
        description: 'someDescription',
      );
    });
  }

  Future<void> addFakeEvents(List<CalendarEvent> event) async {
    await Future.delayed(Duration(milliseconds: Random().nextInt(500) + 500));
  }
}
