import 'package:public_transport/public_transport.dart';

class Route {
  final String id;
  final String? gtfsId;
  final String? agencyName;
  final TransitMode mode;
  final int? type;
  final String? shortName;
  final String? longName;
  final String? color;
  final String? textColor;

  Route({
    required this.id,
    this.gtfsId,
    this.agencyName,
    required this.mode,
    this.type,
    this.shortName,
    this.longName,
    this.color,
    this.textColor,
  });
}
