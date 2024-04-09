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








/*import 'dart:io';

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
//import '../../../helpers/extensions.dart';
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
    final currentUser = FirebaseAuth.instance.currentUser;
    _nameController.text = currentUser?.displayName ?? '';
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
        title: Text('Profile', style: TextStyle(color: Colors.white)),
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
          child: CircularProgressIndicator(color: Color.fromARGB(255, 137, 147, 161)),
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
                  child: CircleAvatar(backgroundImage: _profileImage),
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
                    await GoogleSignIn().disconnect();
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
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
      barrierDismissible: false,
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
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _updateUserName(_nameController.text).then((_) => Navigator.of(context).pop());
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
      File imageFile = File(pickedFile.path);
      _uploadProfileImage(imageFile);
    }
  }

  Future<void> _updateUserName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: name);
      await user.reload();
      setState(() => _nameController.text = name);
    }
  }

Future<void> _uploadProfileImage(File image) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final storageRef = FirebaseStorage.instance.ref();
    final userProfileImageRef = storageRef.child('profile_images/${user.uid}/profile_pic.png');

    try {
      await userProfileImageRef.putFile(image);
      final url = await userProfileImageRef.getDownloadURL();
      await user.updateProfile(photoURL: url);
      await user.reload(); // This line refreshes the user data

      // Now, update your application state to reflect the change
      setState(() {
        // It's safe to fetch the updated currentUser object now
        _profileImage = NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!);
      });
    } catch (e) {
      print("Error uploading image: $e");
    }
  }
}


}*/




/*import 'dart:io';

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
// Assuming the extension methods are correctly defined in '../../../helpers/extensions.dart';
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
    final currentUser = FirebaseAuth.instance.currentUser;
    _nameController.text = currentUser?.displayName ?? '';
    _profileImage = currentUser?.photoURL != null
        ? NetworkImage(currentUser!.photoURL!)
        : AssetImage('assets/image/profile.png') as ImageProvider<Object>?;
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
                    await GoogleSignIn().disconnect();
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
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
      barrierDismissible: false,
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
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _updateUserName(_nameController.text);
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
      File imageFile = File(pickedFile.path);
      await _uploadProfileImage(imageFile);
    }
  }

  Future<void> _updateUserName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: name);
      await user.reload(); // This ensures the user object is updated
      setState(() {
        // This will refresh the UI with the updated name
        _nameController.text = name;
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
      await user.reload(); // This ensures the user object is updated
      setState(() {
        // This will refresh the UI with the updated profile image
        _profileImage = NetworkImage(url);
      });
    }
  }
}
*/





