/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  final String title;
  const AdminPanel({super.key, required this.title});

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lonController = TextEditingController();
  DocumentSnapshot? currentDoc;

  void showEditDialog({DocumentSnapshot? doc}) {
    if (doc != null) {
      currentDoc = doc;
      nameController.text = doc['name'];
      latController.text = doc['latitude'].toString();
      lonController.text = doc['longitude'].toString();
    } else {
      clearFields();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(doc == null ? 'Add New Marker' : 'Edit Marker'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Marker Name')),
              TextField(controller: latController, decoration: const InputDecoration(labelText: 'Latitude')),
              TextField(controller: lonController, decoration: const InputDecoration(labelText: 'Longitude')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              clearFields();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              addOrUpdateMarker();
              Navigator.pop(context);
            },
            child: Text(doc == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void addOrUpdateMarker() {
    if (nameController.text.isNotEmpty && latController.text.isNotEmpty && lonController.text.isNotEmpty) {
      Map<String, dynamic> data = {
        'name': nameController.text,
        'latitude': double.tryParse(latController.text),
        'longitude': double.tryParse(lonController.text),
      };

      if (currentDoc == null) {
        FirebaseFirestore.instance.collection('markers').add(data);
      } else {
        currentDoc!.reference.update(data);
      }
      clearFields();
    }
  }

  void clearFields() {
    nameController.clear();
    latController.clear();
    lonController.clear();
    currentDoc = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('markers').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return ListTile(
                        title: Text(doc['name']),
                        subtitle: Text('Lat: ${doc['latitude']}, Lon: ${doc['longitude']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => showEditDialog(doc: doc),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => doc.reference.delete(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showEditDialog(),
                  child: const Text('Add New Marker'),
                ),
              ],
            );
          }
          return const Text('No markers found');
        },
      ),
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  final String title;
  const AdminPanel({super.key, required this.title});

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lonController = TextEditingController();
  DocumentSnapshot? currentDoc;

  void showEditDialog({DocumentSnapshot? doc}) {
    if (doc != null) {
      currentDoc = doc;
      nameController.text = doc['name'];
      latController.text = doc['latitude'].toString();
      lonController.text = doc['longitude'].toString();
    } else {
      clearFields();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(doc == null ? 'Add New Marker' : 'Edit Marker'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Marker Name')),
              TextField(controller: latController, decoration: const InputDecoration(labelText: 'Latitude')),
              TextField(controller: lonController, decoration: const InputDecoration(labelText: 'Longitude')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              clearFields();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              addOrUpdateMarker();
              Navigator.pop(context);
            },
            child: Text(doc == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void addOrUpdateMarker() {
    if (nameController.text.isNotEmpty && latController.text.isNotEmpty && lonController.text.isNotEmpty) {
      Map<String, dynamic> data = {
        'name': nameController.text,
        'latitude': double.tryParse(latController.text),
        'longitude': double.tryParse(lonController.text),
      };

      if (currentDoc == null) {
        FirebaseFirestore.instance.collection('markers').add(data);
      } else {
        currentDoc!.reference.update(data);
      }
      clearFields();
    }
  }

  void clearFields() {
    nameController.clear();
    latController.clear();
    lonController.clear();
    currentDoc = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('markers').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(doc['name']),
                            subtitle: Text('Lat: ${doc['latitude']}, Lon: ${doc['longitude']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => showEditDialog(doc: doc),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => doc.reference.delete(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () => showEditDialog(),
                    child: const Text('Add New Marker'),
                  ),
                ),
              ],
            );
          }
          return const Text('No markers found');
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AdminPanel(title: 'Admin Panel'),
    debugShowCheckedModeBanner: false,
  ));
}
