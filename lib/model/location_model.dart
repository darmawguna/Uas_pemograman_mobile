// lib/models/location.dart

import 'package:latlong2/latlong.dart';

class LocationModel {
  final LatLng point;
  final String address;
  final String description;

  LocationModel({
    required this.point,
    required this.address,
    required this.description,
  });
}
