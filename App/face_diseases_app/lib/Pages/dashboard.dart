

import 'package:face_diseases_app/Login/screens/home/ui/home_sceren.dart';
import 'package:face_diseases_app/Pages/channel.dart';
import 'package:face_diseases_app/Pages/video.dart';
import 'package:flutter/material.dart';

import 'about.dart';
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
    "Face Diseases",
    "Near By Clinic",
    "Doctors",
    "Learn Videos",
    "Chat",
    "About",
    "Profile",
  ];

  @override
  Widget build(BuildContext context){
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
      
      
      
      body:SingleChildScrollView(
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
                width: width ,
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
                        onTap: (){},
                        child: Icon(
                          Icons.sort,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              image: DecorationImage(
                              image: AssetImage(
                                "image/download.png",
                                )
                              )
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
                              "Hi, Sachith",
                              style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              ),
                            ),
                        
                            SizedBox(height: 1),
                              Text(
                                "Scan Your Diseases",
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
                      width: width ,
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
                                onTap: () async{ //Details of the card clicked

                                
                          // push pages
                          
                            if (titles[index] == "Face Diseases") {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaceDiseasesPage()));
                            }
                            else if (titles[index] == "Scan") {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanPage()));
                            }
                            
                            else if (titles[index] == "Near By Clinic") {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NearByClinicPage())
                            );
                            }
                            else if (titles[index] == "Learn Videos") {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                            YoutubeVideoListScreen (videos: youtubeVideos)),
                              );
                            }
                            else if (titles[index] == "Profile") {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            }

                          else if (titles[index] == "About") {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutPage()),
                              );
                            }
                            else if (titles[index] == "Doctors") {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChannelPage()),
                              );
                            }
                            
                          else {
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
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                Image.asset(imgData[index],
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















/*class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<Map<String, dynamic>> options = [
      {"icon": Icons.camera, "title": "Scan", "page": ScanPage()},
      {"icon": Icons.face, "title": "Face Diseases", "page": FaceDiseasesPage()},
      {"icon": Icons.local_hospital, "title": "Near By Clinic", "page": NearByClinicPage()},
      {"icon": Icons.video_library, "title": "Learn Videos", "page": YoutubeVideoListScreen (videos: youtubeVideos)}, // Add necessary parameters
      {"icon": Icons.message, "title": "Chat", }, // Assume you have a ChatPage
      {"icon": Icons.info, "title": "About", "page": AboutPage()},
      {"icon": Icons.person, "title": "Profile", }, // Assume you have a ProfilePage
    ];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 245),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.sort, color: Colors.white, size: 30),
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/profile.png"), // Update with correct asset
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Welcome!", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Scan Your Diseases", style: TextStyle(color: Colors.white70, fontSize: 18)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: (width / 2) / (height / 4),
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => options[index]['page'])),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(options[index]['icon'], size: 50, color: Colors.blueGrey),
                          SizedBox(height: 10),
                          Text(options[index]['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/