import 'package:face_diseases_app/Location/place_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:travelfreeapp/admin/place_location.dart';

class MapSelect extends StatefulWidget {
  const MapSelect({
    super.key,
    this.location =
        const PlaceLocation(latitude: 37.422, longitude: -122.084, address: ''),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;
  @override
  State<MapSelect> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapSelect> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
            )
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
