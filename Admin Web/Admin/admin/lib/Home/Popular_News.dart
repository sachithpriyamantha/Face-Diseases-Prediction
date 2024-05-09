/*// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminNewsPage extends StatefulWidget {
  const AdminNewsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminNewsPageState createState() => _AdminNewsPageState();
}

class _AdminNewsPageState extends State<AdminNewsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to handle adding or updating news items
  void _addOrUpdateNews({String? docId}) async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();
    String imageUrl = _imageUrlController.text.trim();
    Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };

    if (docId == null) {
      // Add new news item
      await _db.collection('news').add(data);
    } else {
      // Update existing news item
      await _db.collection('news').doc(docId).update(data);
    }
    // Clear the text fields after operation
    _titleController.clear();
    _descriptionController.clear();
    _imageUrlController.clear();
    // ignore: use_build_context_synchronously
    Navigator.pop(context); // Close the dialog after operation
  }

  // Function to show the edit/add dialog
  void _showEditDialog({String? docId, String? title, String? description, String? imageUrl}) {
    _titleController.text = title ?? '';
    _descriptionController.text = description ?? '';
    _imageUrlController.text = imageUrl ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(docId == null ? 'Add News Item' : 'Edit News Item'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _addOrUpdateNews(docId: docId),
            child: Text(docId == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Popular News'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('news').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['title']),
                  subtitle: Text(data['description']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditDialog(
                          docId: document.id,
                          title: data['title'],
                          description: data['description'],
                          imageUrl: data['imageUrl'],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _db.collection('news').doc(document.id).delete(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }
          return const Text('No news items found');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AdminNewsPage(),
    debugShowCheckedModeBanner: false,
  ));
}
*/


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminNewsPage extends StatefulWidget {
  const AdminNewsPage({super.key});

  @override
  _AdminNewsPageState createState() => _AdminNewsPageState();
}

class _AdminNewsPageState extends State<AdminNewsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to handle adding or updating news items
  void _addOrUpdateNews({String? docId}) async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();
    String imageUrl = _imageUrlController.text.trim();
    Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };

    if (docId == null) {
      // Add new news item
      await _db.collection('news').add(data);
    } else {
      // Update existing news item
      await _db.collection('news').doc(docId).update(data);
    }
    // Clear the text fields after operation
    _titleController.clear();
    _descriptionController.clear();
    _imageUrlController.clear();
    // ignore: use_build_context_synchronously
    Navigator.pop(context); // Close the dialog after operation
  }

  // Function to show the edit/add dialog
  void _showEditDialog({String? docId, String? title, String? description, String? imageUrl}) {
    _titleController.text = title ?? '';
    _descriptionController.text = description ?? '';
    _imageUrlController.text = imageUrl ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(docId == null ? 'Add News Item' : 'Edit News Item'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _addOrUpdateNews(docId: docId),
            child: Text(docId == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Popular News'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('news').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(data['description']),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showEditDialog(
                                docId: document.id,
                                title: data['title'],
                                description: data['description'],
                                imageUrl: data['imageUrl'],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _db.collection('news').doc(document.id).delete(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }
          return const Text('No news items found');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AdminNewsPage(),
    debugShowCheckedModeBanner: false,
  ));
}
