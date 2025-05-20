import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const MapWidget({
    Key? key,
    this.initialLatitude = 4.6097, // Bogotá por defecto
    this.initialLongitude = -74.0817,
  }) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId('initial_position'),
        position: LatLng(widget.initialLatitude, widget.initialLongitude),
        infoWindow: InfoWindow(title: 'Tu ubicación'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLatitude, widget.initialLongitude),
        zoom: 15,
      ),
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
