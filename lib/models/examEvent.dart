import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExamEvent {
  final String id;
  final String predmet;
  final DateTime dateTime;
  final LatLng location;
  final String locationName;

  ExamEvent({
    required this.id,
    required this.predmet,
    required this.dateTime,
    required this.location,
    required this.locationName,
  });
}
