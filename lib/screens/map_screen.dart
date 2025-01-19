import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final LatLng _initialLocation = LatLng(41.9981, 21.4254); // Example location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Locations')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialLocation, zoom: 15),
        onMapCreated: (controller) => _mapController = controller,
        markers: {
          Marker(
            markerId: MarkerId('example_location'),
            position: _initialLocation,
            infoWindow: InfoWindow(title: 'Exam Location', snippet: 'University Hall'),
          ),
        },
      ),
    );
  }
}
