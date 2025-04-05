/// All the Event Action Types expected by the back-end
/// The [value] should match the back-end value
enum EventActionType {
  navigation(value: 'navigation');

  const EventActionType({
    required this.value,
  });

  /// Matches the value of the event action type on the backend side.
  final String value;
}
