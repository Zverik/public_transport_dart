import 'package:public_transport/src/models/stop.dart';

class Departure extends Stop {
  final DateTime departure;

  Departure({required super.id, required super.location, required super.name, required this.departure});
}