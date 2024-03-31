
import 'package:awesome_dialog/awesome_dialog.dart';
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


