

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:face_diseases_app/Chat/ui/screen/chat_screen.dart';
import 'package:face_diseases_app/Login/screens/home/ui/home_sceren.dart';
import 'package:face_diseases_app/Pages/PopularNews.dart';
import 'package:face_diseases_app/Pages/channel.dart';
import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:face_diseases_app/Pages/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {});
  }

  void _onIconTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,
        color: Color.fromARGB(255, 55, 237, 240),
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        items: <Widget>[
          Icon(Icons.home_outlined, size: 30),
          
          Icon(Icons.dashboard_customize_outlined, size: 30),
          Icon(Icons.add_a_photo_outlined, size: 30,),
          Icon(Icons.message_outlined, size: 30),
          Icon(Icons.manage_accounts_outlined, size: 30),
        ],
        onTap: _onIconTapped,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          HomeContent(),
          Dashboard(),
          ScanPage(),
          Chat(user: user!),
          ProfilePage()
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(name: 'Dr. (MRS) P. SENAKA', specialty: 'Dermatologist', distance: 'Hambantota Hospital', imageUrl: 'https://i1.rgstatic.net/ii/profile.image/751258864480260-1556125479393_Q512/Indira-Kahawita.jpg'),
    Doctor(name: 'Dr. S. ABEYKEERTHI', specialty: 'Dermatologist', distance: 'Anuradhapura Hospital', imageUrl: 'https://groundviews.org/wp-content/uploads/2012/08/Screen-Shot-2012-08-27-at-11.37.32-PM.jpg'),
    Doctor(name: 'Dr. UWAYSE AHAMED', specialty: 'Dermatologist', distance: 'Colombo Hospital', imageUrl: 'https://www.happysrilankans.com/wp-content/uploads/2020/11/Dr.-Uvais-Ahamed.jpg'),
    // ... more doctors
  ];
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> carouselItems = [
      {
        'image': 'image/facelearn.webp',
        'text': 'Learn Face Diseases',
        'color': Colors.blue,
      },
      {
        'image': 'image/effect.jpg',
        'text': 'Communicate Effectively',
        'color': Colors.green,
      },
      {
        'image': 'image/ex.jpg',
        'text': 'Explore Resources',
        'color': Colors.orange,
      },
    ];


    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
           
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 30, 33, 128),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTopBar(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  child: RichText(
  textAlign: TextAlign.center,
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Hi ${FirebaseAuth.instance.currentUser!.displayName},\nWelcome to ',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      TextSpan(
        text: 'Face Guardian!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.yellow, // Change this color to the one you want for "Face Guardian"
        ),
      ),
    ],
  ),
),

                ),
                SizedBox(height: 16), // Adjust the space as per design
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 20),
              children: <Widget>[
                _buildSectionHeader(context, 'Empower Yourself'),
                SizedBox(
          height: 150,
          // Set the height of the slider here
          child: CarouselSlider.builder(
            itemCount: carouselItems.length,
            itemBuilder: (context, index, realIndex) {
              final item = carouselItems[index];
              return Container(
              
                // No need to set margins here if you're using SizedBox
                decoration: BoxDecoration(
                  color: item['color'],
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: AssetImage(item['image']),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
                ),
                      child: Center(
                        child: Text(
                          item['text'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    aspectRatio: 2.0,
                  ),
                ),
                ),
          _buildSectionHeader(context, 'Doctors'), // Doctors section with "View More"
          _buildNearbyDoctorsList(context),
          _buildSectionHeader(context, 'Popular News'), // No "View More" for other sections
          _buildPopularNews(context),// New widget for popular news
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildNearbyDoctorsList(BuildContext context) {
    return Container(
      height: 170.0, // Set a height that suits your design
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Container(
            width: 200.0, // Set a width that suits your design
            padding: EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(doctor.imageUrl),
                    radius: 30.0,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    doctor.specialty,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    doctor.distance,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  
                ],
              ),
              
            ),
            
          );
        },
      ),
    );
  }




Widget _buildPopularNews(BuildContext context) {
  List<Map<String, dynamic>> newsItems = [
    {
      'title': 'Eczema and the cold',
      'description':
          'Eczema is a skin condition that makes your skin dry, itchy, and inflamed.',/*  It can show up as rashes, scaly patches, blisters, or infected skin. It affects about 30% of Americans, mostly children and adolescents. The most common type of',*/
      'imageUrl': 'https://magazine.medlineplus.gov/images/uploads/main_images/eczemaComp980x587.jpg'
    },
    {
      'title': 'Identifying common conditions',
      'description':
          'Sometimes, due to our environments and genes, our skin gets, well, unhappy.', /* But how can you tell the difference between a minor rash and a more serious condition? Read our quick rundown of five common skin conditions and what they look like. Also, be sure to talk to a dermatologist, a doctor who specializes in skin conditions, or other health care provider for a full diagnosis and care.',*/
      'imageUrl': 'https://magazine.medlineplus.gov/images/uploads/main_images/skin-101-480.jpg'
    },
    {
      'title': 'Healthcare Advances',
      'description':
          'Recent advancements in healthcare could change the way diseases are treated.',
      'imageUrl': 'https://via.placeholder.com/150'
    },
  ];

  return Column(
    children: newsItems.map((item) {
      return Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 174, 224, 234),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // Rounded corners for the image
            child: Image.network(item['imageUrl'], width: 80, height: 80, fit: BoxFit.cover),
          ),
          title: Text(
            item['title'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(item['description']),
        ),
      );
    }).toList(),
  );
}

/*Widget _buildPopularNews(BuildContext context) {
  final Stream<QuerySnapshot> _newsStream = FirebaseFirestore.instance.collection('news').snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: _newsStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }
      return Column(
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> news = document.data()! as Map<String, dynamic>;
          return Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 205, 208, 209),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(news['imageUrl'], width: 80, height: 80, fit: BoxFit.cover),
              ),
              title: Text(
                news['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(news['description']),
            ),
          );
        }).toList(),
      );
    },
  );
}*/


  Widget _buildTopBar() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.menu, color: Colors.white),
            CircleAvatar(
              child: FirebaseAuth.instance.currentUser!.photoURL == null
                  ? Image.asset('image/profile.png')
                  : FadeInImage.assetNetwork(
                      placeholder: 'image/loading.gif',
                      image: FirebaseAuth.instance.currentUser!.photoURL!,
                      fit: BoxFit.cover,
                    ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSectionHeader(BuildContext context, String title) {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (title == "Doctors")  // Only for the Doctors section
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChannelPage()), // Assuming ChannelPage exists
              );
            },
            child: Text(
              "View More",
              style: TextStyle(color: const Color.fromARGB(255, 65, 66, 66), fontWeight: FontWeight.bold),
            ),
          ),
                  if (title == "Popular News")  // Only for the Doctors section
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage()), // Assuming ChannelPage exists
              );
            },
            child: Text(
              "View More",
              style: TextStyle(color: const Color.fromARGB(255, 65, 66, 66), fontWeight: FontWeight.bold),
            ),
          ),
      ],
    ),
  );
}





}
class Doctor {
  final String name;
  final String specialty;
  final String distance;
  final String imageUrl;  // Change to imageUrl

  Doctor({required this.name, required this.specialty, required this.distance, required this.imageUrl});

  static Doctor fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Doctor(
      name: data['name'],
      specialty: data['specialty'],
      distance: data['hospital'],
      imageUrl: data['imageUrl'] as String? ?? '', // Provide a default URL
    );
  }
}
