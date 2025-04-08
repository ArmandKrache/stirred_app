import 'dart:async';

import 'package:stirred_app/core/events/event.dart';
import 'package:stirred_app/core/events/event_types.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

/// TODO: Implement EventApi in Stirred Common Domain Package
abstract class EventApi {

  Future<Result<void, StirError>> sendEvents({List<Event> events});
}

/// Static class that manages the events
/// TODO: Refactor to use dependency injection and remove the need for the init method
/// TODO: Add a documentation for the class
class EventManager {
  static String currentRoutePath = '';
  static List<Event> events = [];
  static EventApi? eventApi;

  EventManager({required EventApi api}) {
    eventApi = api;
  }
  
  static void addEvent({
    required String actionType,
    Map<String, dynamic>? extraData,
    String? sExtra1,
    String? sExtra2,
    double? fExtra1,
    double? fExtra2,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final tags = <String, dynamic>{
      if (sExtra1 != null) 's_extra_1': sExtra1,
      if (sExtra2 != null) 's_extra_2': sExtra2,
      if (fExtra1 != null) 'f_extra_1': fExtra1,
      if (fExtra2 != null) 'f_extra_2': fExtra2,
    };

    if (extraData != null) {
      tags.addAll(extraData);
    }

    events.add(
      Event(
        key: actionType,
        tags: tags,
        timestamp: timestamp,
        sExtra1: sExtra1,
        sExtra2: sExtra2,
        fExtra1: fExtra1,
        fExtra2: fExtra2,
      ),
    );

    // log('Event added: ${events.last.toJson()}');

    /// Send events when the list has 30 items and if the length is a multiple of 10,
    /// to prevent spamming the api at every new event if the list has not been cleared because the sending failed
    if (events.length >= 30 && events.length % 10 == 0) {
      unawaited(sendEvents());
    }
  }

  static Future<void> sendEvents() async {
    if (eventApi == null) return;

    final eventsBatch = List<Event>.from(events);
    events.clear();

    final result = await eventApi!.sendEvents(events: eventsBatch);

    result.when(
      success: (_) {},
      failure: (error) {
        events = eventsBatch + events;
      },
    );
  }

  static void addEnterNavigationEvent({required String newLocation, bool forceEvent = false, String? accessedFrom}) {
    if (forceEvent || EventManager.currentRoutePath != newLocation) {
      final extraData = <String, dynamic>{};
      if (accessedFrom != null) {
        extraData['accessed_from'] = accessedFrom;
      }

      EventManager.addEvent(
        actionType: EventActionType.navigation.value,
        sExtra1: 'enter',
        sExtra2: newLocation,
        extraData: extraData,
      );
      EventManager.currentRoutePath = newLocation;
    }
  }
}
