

import 'package:admin/Doctors/chanel.dart';
import 'package:admin/Home/Popular_News.dart';
import 'package:admin/Location/admin_panel.dart';
import 'package:admin/YoutubeVideo/addVideo.dart';
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
            icon: Icons.location_city,
            color: Colors.lightBlue,
            onTap: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminPanel(title: 'Locations')),
    );},
          ),
          DashboardCard(
  title: 'YouTube Videos',
  icon: Icons.video_call,
  color: Colors.orange,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VideoManagementPage()),
    );
  },
),

          
DashboardCard(
            title: 'Doctors',
            icon: Icons.medical_services,
            color: Colors.pink,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DoctorManagementPage()),
              );
            },
          ),
          
          
DashboardCard(
  title: 'Popular News', 
  icon: Icons.newspaper, 
  color: Colors.green,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminNewsPage()),
    );
  },
),

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
