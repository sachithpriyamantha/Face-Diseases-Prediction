/*import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/no_internet.dart';
import '../../../helpers/extensions.dart';
import '../../../theming/styles.dart';
import '/routing/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 228, 83, 254),
      
            appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
          color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 22, 0, 147),
      ),

            extendBody: true,

        

      body: OfflineBuilder(
        
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected ? _homePage(context) : const BuildNoInternet();
        },
        child: const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 137, 147, 161),
          ),
        ),
      ),
    );
  }

  SafeArea _homePage(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: FirebaseAuth.instance.currentUser!.photoURL == null
                    ? Image.asset('image/profile.png')
                    : FadeInImage.assetNetwork(
                        placeholder: 'image/loading.gif',
                        image: FirebaseAuth.instance.currentUser!.photoURL!,
                        fit: BoxFit.cover,
                      ),
              ),
              Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: TextStyles.font15DarkBlue500Weight
                    .copyWith(fontSize: 30.sp),
              ),
              AppTextButton(
                buttonText: 'Sign Out',
                textStyle: TextStyles.font15DarkBlue500Weight,
                onPressed: () async {
                  try {
                    GoogleSignIn().disconnect();
                    FirebaseAuth.instance.signOut();
                    context.pushNamedAndRemoveUntil(
                      Routes.loginScreen,
                      predicate: (route) => false,
                    );
                  } catch (e) {
                    await AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Sign out error',
                      desc: e.toString(),
                    ).show();
                  }
                  
                },
                
              ),
              
            ],
          ),
          
        ),
      ),
    );
  }
}

*/


/*
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/no_internet.dart';
import '../../../helpers/extensions.dart';
import '../../../theming/styles.dart';
import '/routing/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();
  ImageProvider? _profileImage;

  @override
  void initState() {
    super.initState();
    _nameController.text = FirebaseAuth.instance.currentUser!.displayName ?? '';
    _profileImage = (FirebaseAuth.instance.currentUser!.photoURL != null
        ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
        : AssetImage('image/profile.png')) as ImageProvider<Object>?; // Ensure you have this image in your assets
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 83, 254),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 22, 0, 147),
      ),
      extendBody: true,
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected ? _homePage(context) : const BuildNoInternet();
        },
        child: const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 137, 147, 161),
          ),
        ),
      ),
    );
  }

  SafeArea _homePage(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: GestureDetector(
                  onTap: () => _pickImage(),
                  child: CircleAvatar(
                    backgroundImage: _profileImage,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _editName(context),
                child: Text(
                  _nameController.text,
                  style: TextStyles.font15DarkBlue500Weight.copyWith(fontSize: 30.sp),
                ),
              ),
              AppTextButton(
                buttonText: 'Sign Out',
                textStyle: TextStyles.font15DarkBlue500Weight,
                onPressed: () async {
                  try {
                    GoogleSignIn().disconnect();
                    FirebaseAuth.instance.signOut();
                    context.pushNamedAndRemoveUntil(
                      Routes.loginScreen,
                      predicate: (route) => false,
                    );
                  } catch (e) {
                    await AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Sign out error',
                      desc: e.toString(),
                    ).show();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editName(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: "Enter new name"),
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
                // Update name in Firebase or locally
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = FileImage(File(pickedFile.path));
      });
      // Optionally, upload the new image to Firebase or handle accordingly
    }
  }
  Future<void> _updateUserName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: name);
      await user.reload();
      setState(() {
        _nameController.text = user.displayName ?? '';
      });
    }
  }
    Future<void> _uploadProfileImage(File image) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images/${user.uid}/profile_pic.png');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      await user.updateProfile(photoURL: url);
      await user.reload();
      setState(() {
        _profileImage = NetworkImage(url);
      });
    }
  }
}


*/



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
