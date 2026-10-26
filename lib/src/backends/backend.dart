import 'package:latlong2/latlong.dart';
import 'package:public_transport/src/models/departure.dart';
import 'package:public_transport/src/models/itinerary.dart';
import 'package:public_transport/src/models/mode.dart';
import 'package:public_transport/src/models/stop.dart';

abstract class Backend {
  Future<List<Stop>> queryStopsInBounds(LatLng southWest, LatLng northEast);

  Future<List<Departure>> queryDepartures({
    Stop? stop,
    LatLng? center,
    int? radius,
    DateTime? time,
    int? windowSeconds,
  });

  Future<List<List<ItineraryLeg>>> planJourney({
    required LatLng from,
    required LatLng to,
    DateTime? time,
    bool isDeparture = true,
    double? walkSpeed,
    List<TransitMode>? modes,
    int? windowSeconds,
  });
}
