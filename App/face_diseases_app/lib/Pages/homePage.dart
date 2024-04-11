
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

  // Page controller to control page transitions
  final PageController _pageController = PageController();
  
  var user;
  
  

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
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      //backgroundColor: Colors.transparent,
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor:Color.fromARGB(0, 233, 248, 255),
      color: Color.fromARGB(255, 51, 187, 51),
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
    // Sample data for the carousel
    final List<Map<String, dynamic>> carouselItems = [
      {
        'image': 'image/facelearn.webp', // Ensure images are in the assets folder
        'text': 'Learn Face Diseases',
        'color': Colors.blue, // Each item can have a specific theme color
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

    final List<String> popularPlaces = [
      'image/news/news1.jpeg',
      'image/news/news2.jpg',
      'image/news/news3.jpg',
      // Add more images as needed
    ];

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
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
                // CarouselSlider goes here
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
                _buildSectionHeader('Latest News'),
                _buildHorizontalList(context, popularPlaces),
              ],
            ),
          ),
        ],
      ),
    );
  }


Widget _buildHorizontalList(BuildContext context, List<String> images) {
  // Assuming each image has associated text. For demonstration, using repetitive text.
  // Ideally, this should be a list of objects with both image and text properties.
  final List<String> newsTexts = [
    '10 Tips To Adapt The Changing Weather\nRead on as we share some strategies to follow during this transition period and how to implement them for better health.',
    'Cases Of Highly Contagious, Drug-Resistant Ringworm Found In US: Report\nThe CDC is concerned about this specific strain since the skin illness reademore....',
    'Dermatology researchers create new tool to measure hyperpigmentation There are currently no globally accepted methods for analyzing hyperpigmentation,\n a condition in which patches of skin are darker than the surrounding skin on the body. While one popular scale exists, it is specific to facial readmore..',
    // Ensure this list matches the length of `images`.
  ];

  List<Widget> newsItems = List.generate(images.length, (index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: ClipRRect( 
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(images[index], fit: BoxFit.cover, width: 1000.0),
            Container(
              // This container is for the text overlay with a semi-transparent background.
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Text(
                newsTexts[index],
                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  });

  return CarouselSlider(
    items: newsItems,
    options: CarouselOptions(
      autoPlay: true,
      aspectRatio: 2.0,
      enlargeCenterPage: true,
      reverse: true, // To simulate left-to-right movement for "Latest News"
    ),
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
          TextButton(
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
          ),
        ],
      ),
    );
  }



  Widget _buildActivityPlaceCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'image/download (1).jpeg', // Update with your asset path
              height: 90,
              width: 160,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Activity Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Location'),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, size: 16),
                      Text('4.8'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




