import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  final Position currentPosition;

  const MyMap({required this.currentPosition, Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController _mapController;
  late Set<Marker> _markers;
  late List<LatLng> _polylineCoordinates;

  @override
  void initState() {
    super.initState();
    _markers = {};
    _polylineCoordinates = [LatLng(widget.currentPosition.latitude, widget.currentPosition.longitude)];
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.currentPosition.latitude, widget.currentPosition.longitude),
        zoom: 15.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        _addMarker();
      },
      markers: _markers,
      polylines: {
        Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: _polylineCoordinates,
        ),
      },
    );
  }

  void _addMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('current_position'),
          position: LatLng(widget.currentPosition.latitude, widget.currentPosition.longitude),
          infoWindow: const InfoWindow(title: 'Current Position'),
        ),
      );
    });
  }
}