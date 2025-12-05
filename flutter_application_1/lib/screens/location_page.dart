import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late GoogleMapController mapController;
  bool _locationPermissionGranted = false;

  // الموقع الافتراضي (مكة المكرمة)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(21.4225, 39.8262),
    zoom: 14.0,
  );

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(21.4225, 39.8262),
      infoWindow: InfoWindow(title: 'موقعك', snippet: 'مكانك الحالي'),
    ),
  };

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }
    if (status.isGranted) {
      setState(() {
        _locationPermissionGranted = true;
      });
    } else {
      // لو المستخدم رفض الصلاحية
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Location permission is required to show your current location',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        backgroundColor: Color(0xFF002E6D),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: _markers,
        myLocationEnabled: _locationPermissionGranted,
        myLocationButtonEnabled: _locationPermissionGranted,
        zoomControlsEnabled: true, // إظهار أزرار التكبير والتصغير
      ),
    );
  }
}
