/*
import 'package:face_diseases_app/Chat/ui/screen/chat_screen.dart';
import 'package:face_diseases_app/Login/screens/home/ui/home_sceren.dart';
import 'package:face_diseases_app/Pages/Report.dart';
import 'package:face_diseases_app/Pages/channel.dart';
import 'package:face_diseases_app/Pages/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'about.dart';
//import 'chat.dart';
import 'face_diseases.dart';
import 'nearbyclinic.dart';
import 'scan.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  int index = 2;
  var height, width;

// list of images
  List imgData = [
    "image/Scan.png",
    "image/report.png",
    "image/diseases.png",
    "image/clinic.png",
    "image/doctor.png",
    "image/learn.png",
    "image/chat.png",
    "image/about.png",
    "image/profile.png",
  ];

// list of dashbord card title
  List titles = [
    "Scan",
    "Daily Report",
    "Face Diseases",
    "Near By Clinic",
    "Doctors",
    "Learn Videos",
    "Chat",
    "About",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      /* bottomNavigationBar: CurvedNavigationBar(
      
      backgroundColor: Colors.transparent,
      color: Colors.deepPurple.shade200,
      animationDuration: Duration(milliseconds: 300),
      height: 60,
      
      items: <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.dashboard, size: 30),
      Icon(Icons.feed, size: 30),

    ],
    
    onTap: (index) {
      setState(() {
              index = index;
            }
          );
        }
      ),*/

      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 0, 0, 0),

          //height: height,

          width: width,
          child: Column(
            children: [
              // top part of the dashboard

              Container(
                decoration: BoxDecoration(),
                height: height * 0.25,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 35,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.sort,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:
                                  FirebaseAuth.instance.currentUser!.photoURL ==
                                          null
                                      ? Image.asset('image/profile.png')
                                      : FadeInImage.assetNetwork(
                                          placeholder: 'image/loading.gif',
                                          image: FirebaseAuth
                                              .instance.currentUser!.photoURL!,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, ${FirebaseAuth.instance.currentUser!.displayName}",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 1),
                          Text(
                            "How can we help you?",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 22, 0, 147),
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 22, 0, 147),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 255, 255),
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),

                  //height: height,
                  width: width,
                  padding: EdgeInsets.only(bottom: 20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: imgData.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: InkWell(
                          onTap: () async {
                            //Details of the card clicked

                            /***********************************************push pages*****************************************/

                            if (titles[index] == "Face Diseases") {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FaceDiseasesPage()));
                            } else if (titles[index] == "Scan") {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ScanPage()));
                            } else if (titles[index] == "Near By Clinic") {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NearByClinicPage()));
                            } else if (titles[index] == "Learn Videos") {
                              var youtubeVideos;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        YoutubeVideoListScreen(
                                            videos: youtubeVideos)),
                              );
                            } else if (titles[index] == "Profile") {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            } else if (titles[index] == "Daily Report") {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => DailyReportPage()),
                              );}
                              else if (titles[index] == "About") {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => AboutPage()),
                              );

                            } else if (titles[index] == "Chat") {
                              final user = FirebaseAuth
                                  .instance.currentUser; // Get the current user
                              if (user != null) {
                                // Navigate to the Chat screen if the user is not null
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Chat(
                                        user: user,
                                        key:
                                            UniqueKey()), // Passing a UniqueKey
                                  ),
                                );
                              } else {
                                // Handle the case where there is no user logged in
                                print(
                                    "No user logged in"); // Consider showing a message or redirecting to the login screen
                              }
                            } else if (titles[index] == "Doctors") {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ChannelPage()),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Item Details"),
                                    content:
                                        Text("Details about the item tapped."),
                                    actions: [
                                      TextButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 0, 0, 0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  imgData[index],
                                  width: 100,
                                ),
                                Text(
                                  titles[index],
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
*/




import 'package:face_diseases_app/Chat/ui/screen/chat_screen.dart';
import 'package:face_diseases_app/Login/screens/home/ui/home_sceren.dart';
import 'package:face_diseases_app/Pages/Report.dart';
import 'package:face_diseases_app/Pages/about.dart';
import 'package:face_diseases_app/Pages/channel.dart';
import 'package:face_diseases_app/Pages/face_diseases.dart';
import 'package:face_diseases_app/Pages/nearbyclinic.dart';
import 'package:face_diseases_app/Pages/scan.dart';
import 'package:face_diseases_app/Pages/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  int index = 2;
  double? height, width;

  // List of images and titles for dashboard cards
  List<String> imgData = [
    "image/Scan.png",
    "image/report.png",
    "image/diseases.png",
    "image/clinic.png",
    "image/doctor.png",
    "image/learn.png",
    "image/chat.png",
    "image/about.png",
    "image/profile.png",
  ];

  List<String> titles = [
    "Scan",
    "Daily Report",
    "Face Diseases",
    "Near By Clinic",
    "Doctors",
    "Learn Videos",
    "Chat",
    "About",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;



    return Scaffold(
      backgroundColor: Color.fromARGB(255, 99, 172, 143),
      body: Column(
        children: [
          buildStaticHeader(context),
          Expanded(child: buildScrollableContent(context)),
        ],
      ),
    );
  }

  Widget buildStaticHeader(BuildContext context) {
    return Container(
      //color: Color.fromARGB(255, 0, 0, 0),
      height: height! * 0.25,
      width: width!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.sort, color: Colors.white, size: 40),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FirebaseAuth.instance.currentUser!.photoURL == null
                        ? Image.asset('image/profile.png')
                        : FadeInImage.assetNetwork(
                            placeholder: 'image/loading.gif',
                            image: FirebaseAuth.instance.currentUser!.photoURL!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How can help you Today?",
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 1),
                const Text(
                  "Active now",
                  style: TextStyle(
                    
                    fontSize: 18,
                    color: Color.fromARGB(255, 192, 188, 188),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 /*Widget buildScrollableContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          /*gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors:[Color.fromARGB(255, 255, 255, 255), 
           // Colors.orange, 
            Colors.indigo],
          ),*/
          boxShadow: const [BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 6)],
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        width: width,
        padding: const EdgeInsets.only(bottom: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            mainAxisSpacing: 25,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: imgData.length,
          itemBuilder: (context, index) => buildDashboardItem(context, index),
        ),
      ),
    );
  }*/
Widget buildScrollableContent(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      width: width,
      padding: const EdgeInsets.only(bottom: 20),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 1.4,  // Adjusted aspect ratio for a more square-like appearance
          mainAxisSpacing: 35,  // Further reduced spacing
          crossAxisSpacing: 15,  // Consistent spacing for visual balance
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: imgData.length,
        itemBuilder: (context, index) => buildDashboardItem(context, index),
      ),
    ),
  );
}





  /*Widget buildDashboardItem(BuildContext context, int index) {
    
    return InkWell(
      
      onTap: () => handleCardTap(context, index),
      child: Container(
       
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 60, 188, 111),
          boxShadow: const [BoxShadow(color: Color.fromARGB(255, 249, 210, 210), spreadRadius: 1, blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(imgData[index], width: 100),
            Text(
              titles[index],
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
*/
Widget buildDashboardItem(BuildContext context, int index) {
  return InkWell(
    onTap: () => handleCardTap(context, index),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),  // Further reduced margins
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 66, 131, 105),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(100, 0, 0, 0),  // Softer shadow
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(0, 3),  // Slight vertical offset for depth
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(imgData[index], width: 80),  // Slightly smaller images
          Text(
            titles[index],
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),  // Smaller text
          ),
        ],
      ),
    ),
  );
}





  void handleCardTap(BuildContext context, int index) {
    // Navigate to different screens based on the tapped title
    switch (titles[index]) {
      case "Scan":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanPage()));
        break;
      case "Daily Report":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DailyReportPage()));
        break;
      case "Face Diseases":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaceDiseasesPage()));
        break;
      case "Near By Clinic":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NearByClinicPage()));
        break;
      case "Learn Videos":
        var youtubeVideos;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        YoutubeVideoListScreen(
                                            videos: youtubeVideos)));
        break;
      case "Profile":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
      case "Chat":
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Chat(user: user, key: UniqueKey())));
        }
        break;
      case "About":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutPage()));
        break;
      case "Doctors":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChannelPage()));
        break;
      default:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Item Details"),
              content: Text("Details about the item tapped."),
              actions: [
                TextButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
    }
  }
}

