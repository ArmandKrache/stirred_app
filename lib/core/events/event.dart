import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String key,
    required int timestamp,
    Map<String, dynamic>? tags,
    String? sExtra1,
    String? sExtra2,
    double? fExtra1,
    double? fExtra2,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
