import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/report_provider.dart';
import 'package:eamar_app/screens/reportSubmittion/personal_info_screen.dart';
import 'package:eamar_app/widgets/location/location_card_widget.dart';
import 'package:eamar_app/widgets/reportSubmittions/button_widget.dart';
import 'package:eamar_app/widgets/reportSubmittions/custom_close_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? _userLocation;
  bool _isLoading = false;
  bool _isNextLoading = false;
  double? _latitude;
  double? _longitude;

  Future<void> _getUserLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled, so prompt the user to enable them
        setState(() {
          _isLoading = false;
          _userLocation = 'Location services are disabled.';
        });
        return;
      }

      // Check permission status
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permission denied, display an error
          setState(() {
            _isLoading = false;
            _userLocation = 'خدمة الموقع غير مفعلة';
          });
          return;
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
          _userLocation = placemarks[0].street ?? placemarks[0].locality;
          _latitude = position.latitude; // Get latitude from Position
          _longitude = position.longitude; // Get longitude from Position
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _userLocation = 'حدث خطأ ما';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _userLocation = 'Error getting location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final reportProvider = Provider.of<ReportProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * .03,
              ),
              child: const CustomClose(),
            ),
            SizedBox(
              height: size.height * .12,
            ),
            const Text(
              'قم بتأكيد موقع البلاغ',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'cairo', fontSize: 20),
            ),
            SizedBox(
              height: size.height * .15,
            ),
            GestureDetector(
              onTap: _getUserLocation,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : LocationCard(
                      location: _userLocation,
                    ),
            ),
            SizedBox(
              height: size.height * .31,
            ),
            GestureDetector(
              onTap: () async {
                if (_latitude != null && _longitude != null) {
                  setState(() {
                    _isNextLoading = true;
                  });

                  // Store location in provider
                  reportProvider.lat = _latitude!;
                  reportProvider.long = _longitude!;
                  reportProvider.location = _userLocation;

                  // Simulate a delay for the loader
                  await Future.delayed(const Duration(seconds: 1));

                  // Navigate to the next screen
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const PersonalInfo()),
                  );

                  setState(() {
                    _isNextLoading = false;
                  });
                } else {
                  // Show an alert or snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      showCloseIcon: true,
                      content: Text(
                        textAlign: TextAlign.right,
                        'الرجاء ادخال موقع البلاغ حني تستطيع المتابعة',
                        style: TextStyle(fontFamily: 'cairo', fontSize: 14),
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: _isNextLoading
                  ? const CircularProgressIndicator()
                  : ReportButton(
                      text: 'التالي',
                      bgColor: primaryColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
