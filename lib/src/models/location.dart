import 'package:latlong2/latlong.dart';

class Location {
  final String? stopId;
  final String? name;
  final LatLng location;

  Location({required this.stopId, required this.name, required this.location});
}