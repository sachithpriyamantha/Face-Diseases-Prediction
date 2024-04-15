import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  final String title;
   const AdminPanel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController latController = TextEditingController();
    final TextEditingController lonController = TextEditingController();

    void addMarker() {
      if (nameController.text.isNotEmpty && latController.text.isNotEmpty && lonController.text.isNotEmpty) {
        FirebaseFirestore.instance.collection('markers').add({
          'name': nameController.text,
          'latitude': double.parse(latController.text),
          'longitude': double.parse(lonController.text),
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Location')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('markers').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                      title: Text(doc['name']),
                      subtitle: Text('Lat: ${doc['latitude']}, Lon: ${doc['longitude']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => doc.reference.delete(),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Marker Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: latController,
                  decoration: const InputDecoration(labelText: 'Latitude'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: lonController,
                  decoration: const InputDecoration(labelText: 'Longitude'),
                ),
              ),
              ElevatedButton(
                onPressed: addMarker,
                child: const Text('Add Marker'),
              ),
            ],
          );
        },
      ),
    );
  }
}
