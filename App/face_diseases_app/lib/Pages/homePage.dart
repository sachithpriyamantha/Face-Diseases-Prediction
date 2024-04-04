
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:face_diseases_app/Login/screens/home/ui/home_sceren.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  // Page controller to control page transitions
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
    });
  }

  void _onIconTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor:Colors.transparent,
      color: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      height: 60,
      
      items: <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.dashboard, size: 30),
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
          HomeScreen()
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  
final List<Map<String, dynamic>> carouselItems = [
    {
      'image': 'image/learn.png', // Ensure images are in the assets folder
      'text': 'Learn Face Diseases',
      'color': Colors.blue // Each item can have a specific theme color
    },
    {
      'image': 'image/diseases.png',
      'text': 'Communicate Effectively',
      'color': Colors.green
    },
    {
      'image': 'assets/images/explore.jpg',
      'text': 'Explore Resources',
      'color': Colors.orange
    },
  ];

  final List<Widget> pageList = [
    HomePage(),
    Dashboard(),
   // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        title: Text('FaceGuardian', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.person_2_sharp),
            onPressed: () => Navigator.pushNamed(context, '/homeScreen'),
          ),
        ],
      ),

      
      body: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            SizedBox(height: 20),
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
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
            SizedBox(height: 30),
            Text(
              'Welcome to FaceGuardian',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _buildFeatureGrid(context),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    // Mock data for grid features
    List<Map<String, dynamic>> features = [
      {'title': 'Feature 1', 'icon': Icons.face},
      {'title': 'Feature 2', 'icon': Icons.search},
      {'title': 'Feature 3', 'icon': Icons.health_and_safety},
      {'title': 'Feature 4', 'icon': Icons.help},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(features[index]['icon'], size: 40, color: Colors.indigo),
              SizedBox(height: 10),
              Text(features[index]['title'], style: TextStyle(fontSize: 16)),
            ],
          ),
        );
      }
    );
  }
}