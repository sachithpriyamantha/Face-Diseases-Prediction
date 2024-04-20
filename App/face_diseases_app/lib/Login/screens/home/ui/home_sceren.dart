/*
import 'package:face_diseases_app/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _bioController = TextEditingController();
  String _userBio = "Tap to edit bio...";
  AnimationController? _controller;
  Animation<double>? _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    _controller?.forward();
  }

  @override
  void dispose() {
    _bioController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  void _editBio() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Bio'),
          content: TextField(
            controller: _bioController,
            decoration: InputDecoration(hintText: "Enter your bio here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _userBio = _bioController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _signOut() async {
    try {
      await GoogleSignIn().signOut();  // Changed from disconnect() to signOut() for a proper sign-out.
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
    } catch (e) {


    }
  }

  @override
  Widget build(BuildContext context) {
    final String profileImagePlaceholder = 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';
    final String userEmail = user?.email ?? 'N/A';

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue.shade900, Colors.lightBlue.shade200],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user?.photoURL ?? profileImagePlaceholder),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 20),
              Text(userEmail, style: TextStyle(fontSize: 16, color: Colors.white)),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _opacity?.value ?? 0,
                duration: Duration(seconds: 1),
                child: GestureDetector(
                  onTap: _editBio,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(_userBio, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildTile(Icons.settings, 'Settings'),
              _buildTile(Icons.help_outline, 'Help & Feedback'),
              _buildTile(Icons.logout_rounded, 'Logout', _signOut),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
*/


/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_diseases_app/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _userBio = "Tap to edit bio...";
  String _userName = "Tap to edit name...";
  AnimationController? _controller;
  Animation<double>? _opacity;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    _controller?.forward();
    _loadUserData();
  }

  void _loadUserData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    setState(() {
      _userName = userDoc['name'] ?? _userName;
      _userBio = userDoc['bio'] ?? _userBio;
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    _nameController.dispose();
    _controller?.dispose();
    super.dispose();
  }
 Future<String> _fetchUsername() async {
    if (user == null) {
      return 'No User';
    }
    try {
      var userData = await _firestore.collection('users').doc(user?.uid).get();
      return userData.data()?['${FirebaseAuth.instance.currentUser!.displayName}'] ?? 'No Username';
    } catch (e) {
      return 'Failed to fetch username';
    }
  }
  void _editBio() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Bio'),
          content: TextField(
            controller: _bioController,
            decoration: InputDecoration(hintText: "Enter your bio here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _userBio = _bioController.text;
                });
                // Update bio in Firestore
                FirebaseFirestore.instance.collection('users').doc(user?.uid).update({'bio': _bioController.text});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editName() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            controller: _nameController..text = _userName,
            decoration: InputDecoration(hintText: "Enter your name here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _userName = _nameController.text;
                });
                // Update name in Firestore
                FirebaseFirestore.instance.collection('users').doc(user?.uid).update({'name': _nameController.text});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _signOut() async {
    try {
      await GoogleSignIn().signOut();  // Changed from disconnect() to signOut() for a proper sign-out.
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
    } catch (e) {
      // Handle logout error
    }
  }

  @override
  Widget build(BuildContext context) {
    final String profileImagePlaceholder = 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';
    //final String userEmail = user?.email ?? 'N/A';

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue.shade900, Colors.lightBlue.shade200],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    NetworkImage(user?.photoURL ?? profileImagePlaceholder),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 20),
              /* Text(
                userEmail,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),*/
              FutureBuilder<String>(
                future: _fetchUsername(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading...",
                        style: TextStyle(color: Colors.white));
                  } else {
                    return Text(
                      snapshot.data!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _opacity?.value ?? 0,
                duration: Duration(seconds: 1),
                child: GestureDetector(
                  onTap: _editBio,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      _userBio,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildTile(Icons.settings, 'Settings'),
              _buildTile(Icons.help_outline, 'Help & Feedback'),
              _buildTile(Icons.logout_rounded, 'Logout', _signOut),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildTile(IconData icon, String title, [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
*/



import 'package:face_diseases_app/Pages/setting/settingpage.dart';
import 'package:face_diseases_app/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _bioController = TextEditingController();
  String _userBio = "Tap to edit bio...";
  AnimationController? _controller;
  Animation<double>? _opacity;
  
  get _editBio => null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    _controller?.forward();
  }

  @override
  void dispose() {
    _bioController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  Future<String> _fetchUsername() async {
    return user?.displayName ?? 'No Username';
  }

  @override
  Widget build(BuildContext context) {
    final String profileImagePlaceholder =
        'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue.shade900, Colors.lightBlue.shade200],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    NetworkImage(user?.photoURL ?? profileImagePlaceholder),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 20),
              FutureBuilder<String>(
                future: _fetchUsername(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading...", style: TextStyle(color: Colors.white));
                  } else {
                    return Text(snapshot.data!, style: TextStyle(fontSize: 16, color: Colors.white));
                  }
                },
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _opacity?.value ?? 0,
                duration: Duration(seconds: 1),
                child: GestureDetector(
                  onTap: _editBio,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(_userBio, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildTile(Icons.settings, 'Settings'),
              _buildTile(Icons.help_outline, 'Help & Feedback'),
              _buildTile(Icons.logout_rounded, 'Logout', _signOut),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildTile(IconData icon, String title, [VoidCallback? onTap]) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(title, style: TextStyle(color: Colors.white)),
    onTap: onTap ?? () {
      if (title == 'Settings') {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
      }
    },
  );
}

  void _signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
    } catch (e) {
      print('Sign out error: $e');
    }
  }
}
