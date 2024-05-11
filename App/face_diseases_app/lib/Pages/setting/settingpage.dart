import 'package:face_diseases_app/Pages/setting/theme.dart';
import 'package:face_diseases_app/Pages/setting/theme_provider.dart';
import 'package:face_diseases_app/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color.fromARGB(255, 69, 84, 255),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.light_mode),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (bool value) {
                    var Provider;
                    Provider.of<ThemeProvider>(context, listen: false).setTheme(
        value ? darkTheme : lightTheme
      );
              },
                  activeTrackColor: Colors.lightBlue,
    activeColor: Colors.blueAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () {
            
              Navigator.of(context).pushNamed(Routes.signupScreen);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: _signOut,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy & Security'),
            onTap: () {
            
            },
          ),
        ],
      ),
    );
  }

  void _signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginScreen, (Route<dynamic> route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: ${e.toString()}'))
      );
    }
  }
}



