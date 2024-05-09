
import 'package:admin/AdminLogin/admin_auth.dart';
import 'package:admin/Dashboard.dart';
//import 'package:admin/admin_panel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
  apiKey: "AIzaSyCp4GfztZhq-YlkAoMzI58DBxaUCOSnDXE",
  projectId: "facediseasesapp-635d0",
  messagingSenderId: "1072306408314",
  appId: "1:1072306408314:web:10705a8c7e4ca8f7aae4c3",));
    

runApp( const MyApp());

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Admin',
      initialRoute: '/',
      routes: {
        '/': (context) => const AdminSignIn(),
        '/admin': (context) =>  const AdminDashboard(),
      },
    );
  }
}

