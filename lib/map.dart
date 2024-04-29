import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ostad_google_map/my_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }

    final Position? position = await Geolocator.getCurrentPosition();
    if (position != null) {
      setState(() {
        _currentPosition = position;
      });
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: _currentPosition != null
          ? MyMap(currentPosition: _currentPosition!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}