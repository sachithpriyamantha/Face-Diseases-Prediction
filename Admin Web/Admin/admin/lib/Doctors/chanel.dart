

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String username; // Used as 'hospital'
  final String image;
  final String info;
  final bool isFollowedByMe;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.image,
    required this.info,
    required this.isFollowedByMe,
  });

  factory User.fromFirestore(Map<String, dynamic> firestore, String id) {
    return User(
      id: id,
      name: firestore['name'] ?? '',
      username: firestore['username'] ?? '',
      image: firestore['imageUrl'] ?? '',
      info: firestore['info'] ?? '',
      isFollowedByMe: firestore['isFollowed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'imageUrl': image,
      'info': info,
      'isFollowed': isFollowedByMe,
    };
  }
}

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    await firestore.collection('users').add(user.toMap());
  }

  Stream<List<User>> getUsers() {
    return firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Future<void> updateUser(User user) async {
    await firestore.collection('users').doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String userId) async {
    await firestore.collection('users').doc(userId).delete();
  }
}

class DoctorManagementPage extends StatefulWidget {
  const DoctorManagementPage({Key? key}) : super(key: key);

  @override
  _DoctorManagementPageState createState() => _DoctorManagementPageState();
}

class _DoctorManagementPageState extends State<DoctorManagementPage> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Doctors'),
      ),
      body: StreamBuilder<List<User>>(
        stream: _firestoreService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<User> users = snapshot.data!;
            if (users.isEmpty) {
              return const Center(child: Text('No doctors found'));
            }
            return ListView(
              children: users.map((User user) => ListTile(
                title: Text(user.name),
                subtitle: Text(user.username),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _addOrEditDoctor(context, user: user),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _firestoreService.deleteUser(user.id),
                    ),
                  ],
                ),
              )).toList(),
            );
          } else {
            return const Center(child: Text('No doctors found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditDoctor(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addOrEditDoctor(BuildContext context, {User? user}) {
    TextEditingController nameController = TextEditingController(text: user?.name);
    TextEditingController hospitalController = TextEditingController(text: user?.username);
    TextEditingController imageController = TextEditingController(text: user?.image);
    TextEditingController infoController = TextEditingController(text: user?.info);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user == null ? 'Add Doctor' : 'Edit Doctor'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: hospitalController, decoration: const InputDecoration(labelText: 'Hospital')),
              TextField(controller: imageController, decoration: const InputDecoration(labelText: 'Image URL')),
              TextField(controller: infoController, decoration: const InputDecoration(labelText: 'Info')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final updatedUser = User(
                id: user?.id ?? FirebaseFirestore.instance.collection('users').doc().id, // Generate new ID if null
                name: nameController.text,
                username: hospitalController.text,
                image: imageController.text,
                info: infoController.text,
                isFollowedByMe: user?.isFollowedByMe ?? false,
              );
              if (user == null) {
                _firestoreService.addUser(updatedUser);
              } else {
                _firestoreService.updateUser(updatedUser);
              }
              Navigator.pop(context);
            },
            child: Text(user == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }
}
