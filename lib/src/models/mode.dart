enum TransitMode {
  walk,
  bicycle,
  car,
  bikeSharing,
  tram,
  subway,
  ferry,
  airplane,
  bus,
  trolleybus,
  coach,
  highspeedRail,
  longDistanceRail,
  nightRail,
  suburban,
  regionalRail,
  onDemand,
  rideSharing,
  funicular,
  aerialLift,
  unknown;

  // TODO: pack into MOTIS?
  static const rail = [highspeedRail, longDistanceRail, nightRail, regionalRail, suburban];
  static const transit = [
    tram,
    ferry,
    airplane,
    bus,
    trolleybus,
    coach,
    ...rail,
    onDemand,
    rideSharing,
    funicular,
    aerialLift,
  ];
}
