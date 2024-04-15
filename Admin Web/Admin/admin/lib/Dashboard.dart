

import 'package:admin/Location/admin_panel.dart';
import 'package:flutter/material.dart';
// Ensure this is properly imported

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
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: <Widget>[
          DashboardCard(
            title: 'LOCATIONS',
            icon: Icons.build,
            color: Colors.lightBlue,
            onTap: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminPanel(title: 'Locations')),
    );},
          ),
          const DashboardCard(title: 'DOCTORS', icon: Icons.local_hospital, color: Colors.orange),
          const DashboardCard(title: 'ARTICLES', icon: Icons.article, color: Colors.pink),
          const DashboardCard(title: 'STAFF', icon: Icons.group, color: Colors.green),
          const DashboardCard(title: 'CHATHUB', icon: Icons.chat, color: Colors.deepPurple),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () {
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
