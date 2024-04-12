/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Locate/locations.dart' as locations;



class NearByClinicPage extends StatefulWidget {
  const NearByClinicPage({super.key});

  @override
  State<NearByClinicPage> createState() => _MyAppState();
}

class _MyAppState extends State<NearByClinicPage> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue[800],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps '),
          centerTitle: true,
          elevation: 2,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}*/

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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 7.5,
        ),
        markers: {
Marker(
  markerId: MarkerId('colombo_hospital'),
  position: LatLng(6.9167, 79.8673),
  infoWindow: InfoWindow(title: 'National Hospital of Sri Lanka, Colombo'),
),

Marker(
  markerId: MarkerId('kandy_hospital'),
  position: LatLng(7.2964, 80.6350),
  infoWindow: InfoWindow(title: 'Kandy Teaching Hospital'),
),

Marker(
  markerId: MarkerId('gampaha_hospital'),
  position: LatLng(7.0873, 79.9990),
  infoWindow: InfoWindow(title: 'Gampaha General Hospital'),
),
Marker(
  markerId: MarkerId('nawaloka_hospital'),
  position: LatLng(6.9271, 79.8575),
  infoWindow: InfoWindow(title: 'Nawaloka Hospital, Colombo'),
),
Marker(
  markerId: MarkerId('asiri_hospital'),
  position: LatLng(6.8774, 79.8611),
  infoWindow: InfoWindow(title: 'Asiri Hospital, Colombo'),
),
Marker(
  markerId: MarkerId('balangoda_base_hospital'),
  position: LatLng(6.6472, 80.7046),
  infoWindow: InfoWindow(title: 'Base Hospital, Balangoda'),
),
Marker(
  markerId: MarkerId('batticaloa_teaching_hospital'),
  position: LatLng(7.7102, 81.6924),
  infoWindow: InfoWindow(title: 'Teaching Hospital, Batticaloa'),
),
Marker(
  markerId: MarkerId('central_leprosy_clinic'),
  position: LatLng(6.9165, 79.8675),
  infoWindow: InfoWindow(title: 'Central Leprosy Clinic, NHSL, Colombo'),
),
Marker(
  markerId: MarkerId('nhsl_colombo'),
  position: LatLng(6.9167, 79.8673),
  infoWindow: InfoWindow(title: 'National Hospital of Sri Lanka, Colombo'),
),
Marker(
  markerId: MarkerId('homagama_base_hospital'),
  position: LatLng(6.8441, 80.0032),
  infoWindow: InfoWindow(title: 'Base Hospital, Homagama'),
),
Marker(
  markerId: MarkerId('karapitiya_teaching_hospital'),
  position: LatLng(6.0535, 80.2170),
  infoWindow: InfoWindow(title: 'Teaching Hospital, Karapitiya, Galle'),
),
Marker(
  markerId: MarkerId('jaffna_teaching_hospital'),
  position: LatLng(9.6685, 80.0074),
  infoWindow: InfoWindow(title: 'Teaching Hospital, Jaffna'),
),
Marker(
  markerId: MarkerId('sirimavo_children_hospital'),
  position: LatLng(7.2672, 80.5938),
  infoWindow: InfoWindow(title: 'Sirimavo Bandaranaike Specialized Children\'s Hospital, Peradeniya'),
),
Marker(
  markerId: MarkerId('kegalle_district_general_hospital'),
  position: LatLng(7.2513, 80.3464),
  infoWindow: InfoWindow(title: 'District General Hospital, Kegalle'),
),
Marker(
  markerId: MarkerId('mawanella_base_hospital'),
  position: LatLng(7.2481, 80.4466),
  infoWindow: InfoWindow(title: 'Base Hospital, Mawanella'),
),
Marker(
  markerId: MarkerId('mulleriyawa_base_hospital'),
  position: LatLng(6.9304, 79.9193),
  infoWindow: InfoWindow(title: 'Base Hospital, Mulleriyawa'),
),
Marker(
  markerId: MarkerId('nawalapitiya_district_general_hospital'),
  position: LatLng(7.0524, 80.5358),
  infoWindow: InfoWindow(title: 'District General Hospital, Nawalapitiya'),
),
Marker(
  markerId: MarkerId('polonnaruwa_district_general_hospital'),
  position: LatLng(7.9403, 81.0188),
  infoWindow: InfoWindow(title: 'District General Hospital, Polonnaruwa'),
),
Marker(
  markerId: MarkerId('x_labs_negombo'),
  position: LatLng(7.2083, 79.8375),
  infoWindow: InfoWindow(title: 'X-LABS Medical and Channel Services, Negombo'),
),
Marker(
  markerId: MarkerId('anuradhapura_teaching_hospital'),
  position: LatLng(8.3452, 80.3881),
  infoWindow: InfoWindow(title: 'Teaching Hospital, Anuradhapura'),
),


        },
      ),
    );
  }
}
