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
        backgroundColor: Theme.of(context).primaryColor,
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
              // Navigate to edit profile page or functionality
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
              // Navigate to notifications settings page or functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy & Security'),
            onTap: () {
              // Navigate to privacy & security settings page or functionality
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



/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Simplified settings management
class SettingsProvider {
  bool _notificationsEnabled = true;

  Future<bool> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    return _notificationsEnabled;
  }

  Future<void> toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    _notificationsEnabled = value;
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  final SettingsProvider settingsProvider = SettingsProvider();

  @override
  void initState() {
    super.initState();
    settingsProvider.loadPreferences().then((enabled) {
      setState(() {
        notificationsEnabled = enabled;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  notificationsEnabled = value;
                });
                settingsProvider.toggleNotifications(value);
              },
            ),
            ListTile(
              title: Text('Manage Account'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Account Management'),
                    content: Text('Manage your account settings here.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Privacy Policy'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Privacy Policy'),
                    content: Text('Here is the privacy policy.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Implement logout functionality
                Navigator.of(context).pop(); 
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/