import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String userLocation = 'User location';

  Future<void> getCurrentLocationApp() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled, so prompt the user to enable them
        return Future.error('Location services are disabled.');
      }

      // Check permission status
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permission denied, display an error
          return Future.error('Location permissions are denied.');
        }
      }

      // If all checks passed, get current location
      Position position = await Geolocator.getCurrentPosition();

      // Get the place name from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Use the first placemark (most likely the nearest)
      if (placemarks.isNotEmpty) {
        setState(() {
          userLocation = placemarks[0].name ?? 'Unknown location';
        });
      } else {
        setState(() {
          userLocation = 'Error getting location';
        });
      }
    } catch (e) {
      setState(() {
        userLocation = 'Error getting location: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocationApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Text(userLocation),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: getCurrentLocationApp,
            child: const Text('Get User Current Location'),
          ),
        ],
      ),
    );
  }
}
