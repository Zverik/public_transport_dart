import 'package:latlong2/latlong.dart';
import 'package:public_transport/src/models/location.dart';
import 'package:public_transport/src/models/mode.dart';
import 'package:public_transport/src/models/route.dart';

class ItineraryLeg {
  final TransitMode mode;
  final Location from;
  final Location to;

  final DateTime departure;
  final DateTime arrival;
  final DateTime scheduledDeparture;
  final DateTime scheduledArrival;
  final int durationSeconds;

  final double distanceMeters;
  final List<LatLng> path;
  final bool? wheelchairAccessible;
  final bool? bikesAllowed;

  final String? headsign;
  final String? tripId;
  final Route? route;

  ItineraryLeg({
    required this.mode,
    required this.from,
    required this.to,
    required this.durationSeconds,
    required this.departure,
    required this.arrival,
    required this.scheduledDeparture,
    required this.scheduledArrival,
    required this.distanceMeters,
    required this.path,
    this.wheelchairAccessible,
    this.bikesAllowed,
    this.headsign,
    this.tripId,
    this.route,
  });
}
