import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? _selectedLocation;
  String _address = "Select a location";

  void _onTap(LatLng position) async {
    setState(() {
      _selectedLocation = position;
      _address = "Loading...";
    });

    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _address =
          "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Failed to get address";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Location")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(22.57, 88.36), // Center on Kolkata
                zoom: 14,
              ),
              onTap: _onTap,
              markers: _selectedLocation != null
                  ? {
                Marker(
                  markerId: const MarkerId("selected"),
                  position: _selectedLocation!,
                )
              }
                  : {},
            ),
          ),
          ListTile(
            title: Text(_address),
            trailing: ElevatedButton(
              onPressed: _selectedLocation == null
                  ? null
                  : () => Navigator.pop(context, _address),
              child: const Text("Select"),
            ),
          )
        ],
      ),
    );
  }
}
