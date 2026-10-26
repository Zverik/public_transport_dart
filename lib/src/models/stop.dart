import 'package:latlong2/latlong.dart';
import 'package:public_transport/src/models/mode.dart';

class Stop {
  final String id;
  final String? gtfsId;
  final LatLng location;
  final String name;
  final String? code;
  final String? timezone;
  final String? description;
  final String? parentId;
  final List<TransitMode>? modes;

  Stop({
    required this.id,
    this.gtfsId,
    required this.location,
    required this.name,
    this.code,
    this.timezone,
    this.description,
    this.parentId,
    this.modes,
  });
}
