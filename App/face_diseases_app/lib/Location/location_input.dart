/*import 'dart:convert';

import 'package:face_diseases_app/Location/location_picked.dart';
import 'package:face_diseases_app/Location/place_location.dart';
import 'package:flutter/material.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
//import 'package:location/location.dart' as location;
//import 'package:travelfreeapp/admin/location_picked.dart';
//import 'package:travelfreeapp/admin/place_location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key, required this.onSelectLocation})
      : super(key: key);

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyBBDYXPXdmxcOPHh5PxeACQPNKNA6kLKKo';
  }

  void _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyBBDYXPXdmxcOPHh5PxeACQPNKNA6kLKKo');
    final response = await http.get(url);
    final resData = jsonDecode(response.body);
    final results = resData['results'];
    if (results != null && results.isNotEmpty) {
      //final address = results[0]['formatted_address'];

      final List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      final Placemark place = placemarks[0];
      final fullAddress =
          '${place.street!}, ${place.locality!}, ${place.country!}';

      setState(() {
        _pickedLocation = PlaceLocation(
          latitude: latitude,
          longitude: longitude,
          address: fullAddress,
        );
        _isGettingLocation = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Selected Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address: $fullAddress'),
              Text('Latitude: ${_pickedLocation!.latitude}'),
              Text('Longitude: ${_pickedLocation!.longitude}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      widget.onSelectLocation(_pickedLocation!);
    }
  }

  Future<void> _getCurrentLocation() async {
    location.Location locationData = location.Location();

    bool serviceEnabled;
    location.PermissionStatus permissionGranted;
    location.LocationData? locationResult;

    serviceEnabled = await locationData.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationData.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await locationData.hasPermission();
    if (permissionGranted == location.PermissionStatus.denied) {
      permissionGranted = await locationData.requestPermission();
      if (permissionGranted != location.PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    try {
      locationResult = await locationData.getLocation();
    } catch (error) {
      print('Error getting location: $error');
    }

    if (locationResult == null) {
      setState(() {
        _isGettingLocation = false;
      });
      return;
    }

    final lat = locationResult.latitude;
    final lng = locationResult.longitude;

    if (lat == null || lng == null) {
      setState(() {
        _isGettingLocation = false;
      });
      return;
    }
    _savePlace(lat, lng);
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapSelect(),
      ),
    );
    if (pickedLocation == null) {
      return;
    }
    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
*/