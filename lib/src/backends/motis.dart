import 'dart:convert' show json;

import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:public_transport/src/backends/backend.dart';
import 'package:public_transport/src/backends/exceptions.dart';
import 'package:public_transport/src/models/departure.dart';
import 'package:public_transport/src/models/itinerary.dart';
import 'package:public_transport/src/models/location.dart';
import 'package:public_transport/src/models/mode.dart';
import 'package:public_transport/src/models/stop.dart';

class MotisBackend extends Backend {
  final String endpoint;

  MotisBackend(this.endpoint);

  String _method(String m) => endpoint.endsWith('/') ? '$endpoint$m' : '$endpoint/$m';

  @override
  Future<List<List<ItineraryLeg>>> planJourney({
    required LatLng from,
    required LatLng to,
    DateTime? time,
    bool isDeparture = true,
    double? walkSpeed,
    List<TransitMode>? modes,
    int? windowSeconds,
  }) async {
    final url = Uri.parse(_method('v6/plan')).replace(
      queryParameters: {
        'fromPlace': '${from.latitude},${from.longitude}',
        'toPlace': '${to.latitude},${to.longitude}',
        if (time != null) 'time': time.toIso8601String(),
        if (walkSpeed != null) 'pedestrianSpeed': walkSpeed.toString(),
        // TODO: modes
        if (windowSeconds != null) 'searchWindow': windowSeconds.toString(),
        'arriveBy': isDeparture ? 'false' : 'true',
      },
    );
    final resp = await http.get(url);
    Map data;
    try {
      data = json.decode(resp.body);
    } on Exception catch (e) {
      throw BackendParseException(e, url.toString());
    }

    if (resp.statusCode != 200) {
      throw BackendException(resp.statusCode, data['error']);
    }

    final result = <List<ItineraryLeg>>[];
    for (final k in ['direct', 'itineraries']) {
      for (final itinerary in data[k]) {
        final legs = <ItineraryLeg>[];
        for (final leg in itinerary['legs']) {
          legs.add(_parseLeg(leg));
        }
        result.add(legs);
      }
    }
    return result;
  }

  ItineraryLeg _parseLeg(Map data) {
    return ItineraryLeg(
      mode: _parseModes(data['mode']).first,
      from: _parseLocation(data['from']),
      to: _parseLocation(data['to']),
      durationSeconds: data['duration'],
      departure: DateTime.parse(data['startTime']),
      arrival: DateTime.parse(data['endTime']),
      scheduledDeparture: DateTime.parse(data['scheduledStartTime']),
      scheduledArrival: DateTime.parse(data['scheduledEndTime']),
      distanceMeters: data['distance'] ?? 100, // TODO: calculate
      headsign: data['headsign'],
      tripId: data['tripId'],
      routeId: data['routeId'],
      routeType: data['routeType'],
      routeShortName: data['routeShortName'],
      routeLongName: data['routeLongName'],
      routeColor: data['routeColor'],
      routeTextColor: data['routeTextColor'],
      bikesAllowed: data['bikesAllowed'],
      wheelchairAccessible: data['wheelchairAccessible'] == "ACCESSIBLE",
      path: decodePolyline(
        data['legGeometry']['points'],
        accuracyExponent: data['legGeometry']['precision'],
      ).map((c) => LatLng(c[0].toDouble(), c[1].toDouble())).toList(),
    );
  }

  Location _parseLocation(Map data) {
    return Location(name: data['name'], location: LatLng(data['lat'], data['lon']), stopId: data['stopId']);
  }

  @override
  Future<List<Departure>> queryDepartures({
    Stop? stop,
    LatLng? center,
    int? radius,
    DateTime? time,
    int? windowSeconds,
  }) {
    final url = _method('v6/stoptimes');
    // TODO: implement queryDepartures
    throw UnimplementedError();
  }

  @override
  Future<List<Stop>> queryStopsInBounds(LatLng southWest, LatLng northEast) {
    final url = _method('v6/map/stops');
    // TODO: implement queryStopsInBounds
    throw UnimplementedError();
  }

  List<TransitMode> _parseModes(String mode) => mode
      .split(',')
      .map(
        (m) => switch (m) {
          'WALK' => [TransitMode.walk],
          'TRAM' => [TransitMode.tram],
          'BUS' => [TransitMode.bus],
          'SUBWAY' => [TransitMode.subway],
          // TODO: others
          'RAIL' => [
            TransitMode.highspeedRail,
            TransitMode.longDistanceRail,
            TransitMode.nightRail,
            TransitMode.regionalRail,
            TransitMode.suburban,
          ],
          String() => [TransitMode.unknown],
        },
      )
      .reduce((a, b) => a + b);
}
