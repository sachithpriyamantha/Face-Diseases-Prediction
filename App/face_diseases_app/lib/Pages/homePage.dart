

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:face_diseases_app/Chat/ui/screen/chat_screen.dart';
import 'package:face_diseases_app/Login/screens/home/ui/home_sceren.dart';
import 'package:face_diseases_app/Pages/dashboard.dart';
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
        color: Color.fromARGB(255, 55, 55, 240),
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.dashboard, size: 30),
          Icon(Icons.message, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: _onIconTapped,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          HomeContent(),
          Dashboard(),
          Chat(user: user!),
          HomeScreen()
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
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
              color: Color.fromARGB(255, 167, 5, 192),
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
                  child: Text(
                    'Hi ${FirebaseAuth.instance.currentUser!.displayName},\nWelcome to Face Guardian!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
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
                _buildSectionHeader('Sachith'),
                CarouselSlider.builder(
                  itemCount: carouselItems.length,
                  itemBuilder: (context, index, realIndex) {
                    final item = carouselItems[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                
                _buildSectionHeader('Popular News'),
                _buildPopularNews(context), // New widget for popular news
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildPopularNews(BuildContext context) {
  List<Map<String, dynamic>> newsItems = [
    {
      'title': 'Eczema and the cold',
      'description':
          'Eczema is a skin condition that makes your skin dry, itchy, and inflamed. It can show up as rashes, scaly patches, blisters, or infected skin. It affects about 30% of Americans, mostly children and adolescents. The most common type of',
      'imageUrl': 'https://magazine.medlineplus.gov/images/uploads/main_images/eczemaComp980x587.jpg'
    },
    {
      'title': 'Identifying common conditions',
      'description':
          'Sometimes, due to our environments and genes, our skin gets, well, unhappy. But how can you tell the difference between a minor rash and a more serious condition? Read our quick rundown of five common skin conditions and what they look like. Also, be sure to talk to a dermatologist, a doctor who specializes in skin conditions, or other health care provider for a full diagnosis and care.',
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          /*TextButton(
            onPressed: () {
// Handle 'More' button press
            },
            child: Text(
              'More',
              style: TextStyle(color: Colors.teal),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
            ),
          ),*/
        ],
      ),
    );
  }
}
