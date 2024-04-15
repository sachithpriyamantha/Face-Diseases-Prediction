// ignore_for_file: file_names

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DASHBOARD'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 3, // Adjust number for screen size
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0, // Adjust ratio for content
        children: const <Widget>[
          DashboardCard(title: 'LOCATIONS', icon: Icons.build, color: Colors.lightBlue),
          DashboardCard(title: 'DOCTORS', icon: Icons.local_hospital, color: Colors.orange),
          DashboardCard(title: 'ARTICLES', icon: Icons.article, color: Colors.pink),
          DashboardCard(title: 'STAFF', icon: Icons.group, color: Colors.green),
          DashboardCard(title: 'CHATHUB', icon: Icons.chat, color: Colors.deepPurple),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Handle the tap event
          print('Card tapped.');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Icon(icon, size: 50, color: color),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title),
                  const SizedBox(height: 8.0),
                  const Text('View | Add', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
