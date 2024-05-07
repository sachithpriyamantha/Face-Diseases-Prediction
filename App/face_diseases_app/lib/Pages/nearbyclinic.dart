import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearByClinicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(7.8731, 80.7718); // Coordinates of Sri Lanka

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    FirebaseFirestore.instance.collection('markers').snapshots().listen((snapshot) {
      setState(() {
        _markers = snapshot.docs.map((doc) {
          double lat = doc.get('latitude');
          double lon = doc.get('longitude');
          return Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(lat, lon),
            infoWindow: InfoWindow(title: doc.get('name')),
          );
        }).toSet();
      });
    }, onError: (e) {
      print("Error loading markers: $e");
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 32, 33),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
        title: const Text('Dermatology Hospital', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 99, 172, 143),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 7.5),
        markers: _markers,
      ),
    );
  }
}



