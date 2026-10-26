import 'package:latlong2/latlong.dart';
import 'package:public_transport/src/models/enums.dart';
import 'package:public_transport/src/models/route.dart';
import 'package:public_transport/src/models/stop.dart';

class Trip {
  final String id;
  final String? gtfsId;
  final Route? route;
  final List<LatLng> path;
  final List<TripStop> stops;
  final String? headsign;
  final bool? wheelchairAccessible;
  final bool? bikesAllowed;

  Trip({
    required this.id,
    this.gtfsId,
    this.route,
    required this.path,
    required this.stops,
    this.headsign,
    this.wheelchairAccessible,
    this.bikesAllowed,
  });
}

class TripStop {
  final Stop stop;
  final String? headsign;
  final DateTime arrival;
  final DateTime departure;
  final DateTime scheduledArrival;
  final DateTime scheduledDeparture;
  final bool hasRealTimeInfo;
  final PickupDropoff pickup;
  final PickupDropoff dropoff;

  TripStop({
    required this.stop,
    required this.headsign,
    required this.arrival,
    required this.departure,
    required this.scheduledArrival,
    required this.scheduledDeparture,
    required this.hasRealTimeInfo,
    required this.pickup,
    required this.dropoff,
  });
}
