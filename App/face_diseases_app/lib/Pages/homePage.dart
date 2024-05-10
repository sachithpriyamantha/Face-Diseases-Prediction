import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:face_diseases_app/Chat/ui/screen/chat_screen.dart';
import 'package:face_diseases_app/Login/screens/home/ui/home_sceren.dart';
import 'package:face_diseases_app/Pages/PopularNews.dart';
import 'package:face_diseases_app/Pages/channel.dart';
import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:face_diseases_app/Pages/scan.dart';
import 'package:face_diseases_app/Pages/setting/settingpage.dart';
import 'package:face_diseases_app/routing/routes.dart';
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
    var _scaffoldKey;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? 'Guest User'),
              accountEmail: Text(user?.email ?? 'no-email@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!) as ImageProvider
                    : AssetImage('image/profile.png') as ImageProvider,
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 99, 172, 143),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Dashboard())); // Closes the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SettingsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginScreen, (route) => false);
              },
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,
        color: Color.fromARGB(255, 99, 172, 143),
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        items: <Widget>[
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.dashboard_customize_outlined, size: 30),
          Icon(
            Icons.add_a_photo_outlined,
            size: 30,
          ),
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
    Doctor(
        name: 'Dr. (MRS) P. SENAKA',
        specialty: 'Dermatologist',
        distance: 'Hambantota Hospital',
        imageUrl:
            'https://i1.rgstatic.net/ii/profile.image/751258864480260-1556125479393_Q512/Indira-Kahawita.jpg'),
    Doctor(
        name: 'Dr. S. ABEYKEERTHI',
        specialty: 'Dermatologist',
        distance: 'Anuradhapura Hospital',
        imageUrl:
            'https://groundviews.org/wp-content/uploads/2012/08/Screen-Shot-2012-08-27-at-11.37.32-PM.jpg'),
    Doctor(
        name: 'Dr. UWAYSE AHAMED',
        specialty: 'Dermatologist',
        distance: 'Colombo Hospital',
        imageUrl:
            'https://www.happysrilankans.com/wp-content/uploads/2020/11/Dr.-Uvais-Ahamed.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> carouselItems = [
                  {
        'image': 'image/problem.jpg',
        'text': 'Problems',
        'color': Colors.orange,
      },
      {
        'image': 'image/facescan.jpg',
        'text': 'Face Diseases Scaning',
        'color': Colors.blue,
      },
      {
        'image': 'image/chat.jpg',
        'text': 'A group chat to Ask Questions',
        'color': Colors.green,
      },
            {
        'image': 'image/loca.jpg',
        'text': 'Nearby Hospital',
        'color': Colors.green,
      },
      {
        'image': 'image/videol.jpg',
        'text': 'Learn Video for Diseases',
        'color': Colors.orange,
      },

    ];

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 99, 172, 143),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTopBar(context),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hi ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                        TextSpan(
                          text:
                              '${FirebaseAuth.instance.currentUser!.displayName}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 244, 238, 54),
                            shadows: [
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                        TextSpan(
                          text: ',\nWelcome to Face Guardian!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(4.0, 4.0),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),






          Expanded(
            /*child: ListView(
              padding: EdgeInsets.only(top: 20),
              children: <Widget>[
                _buildSectionHeader(context, 'Empower Yourself'),
                SizedBox(
                  height: 150,
                  child: CarouselSlider.builder(
                    itemCount: carouselItems.length,
                    itemBuilder: (context, index, realIndex) {
                      final item = carouselItems[index];
                      return Container(
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
                _buildSectionHeader(context, 'Doctors'),
                _buildNearbyDoctorsList(context),
                _buildSectionHeader(context, 'Popular News'),
                _buildPopularNews(context),
              ],
            ),*/
            child: ListView(
  padding: EdgeInsets.only(top: 20),
  children: <Widget>[
    _buildSectionHeader(context, 'Empower Yourself'),
    SizedBox(
      height: 150,
      child: CarouselSlider.builder(
        itemCount: carouselItems.length,
        itemBuilder: (context, index, realIndex) {
          final item = carouselItems[index];
          return Stack(
            children: [
              Container(
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
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 58, 57, 57).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    item['text'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
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
    _buildSectionHeader(context, 'Doctors'),
    _buildNearbyDoctorsList(context),
    _buildSectionHeader(context, 'Popular News'),
    _buildPopularNews(context),
  ],
),

          ),
        ],
      ),
    );
  }

  Widget _buildNearbyDoctorsList(BuildContext context) {
    return Container(
      height: 170.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Container(
            width: 200.0,
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
            'Eczema is a skin condition that makes your skin dry, itchy, and inflamed.',
        /*  It can show up as rashes, scaly patches, blisters, or infected skin. It affects about 30% of Americans, mostly children and adolescents. The most common type of',*/
        'imageUrl':
            'https://magazine.medlineplus.gov/images/uploads/main_images/eczemaComp980x587.jpg'
      },
      {
        'title': 'Identifying common conditions',
        'description':
            'Sometimes, due to our environments and genes, our skin gets, well, unhappy.',
        /* But how can you tell the difference between a minor rash and a more serious condition? Read our quick rundown of five common skin conditions and what they look like. Also, be sure to talk to a dermatologist, a doctor who specializes in skin conditions, or other health care provider for a full diagnosis and care.',*/
        'imageUrl':
            'https://magazine.medlineplus.gov/images/uploads/main_images/skin-101-480.jpg'
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
            color: Color.fromARGB(255, 195, 240, 219),
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
              child: Image.network(item['imageUrl'],
                  width: 80, height: 80, fit: BoxFit.cover),
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

  Widget _buildTopBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            CircleAvatar(
              backgroundImage: FirebaseAuth.instance.currentUser!.photoURL ==
                      null
                  ? AssetImage('image/profile.png') as ImageProvider
                  : NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
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
          if (title == "Doctors")
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChannelPage()),
                );
              },
              child: Text(
                "View More",
                style: TextStyle(
                    color: const Color.fromARGB(255, 65, 66, 66),
                    fontWeight: FontWeight.bold),
              ),
            ),
          if (title == "Popular News")
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage()),
                );
              },
              child: Text(
                "View More",
                style: TextStyle(
                    color: const Color.fromARGB(255, 65, 66, 66),
                    fontWeight: FontWeight.bold),
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
  final String imageUrl;

  Doctor(
      {required this.name,
      required this.specialty,
      required this.distance,
      required this.imageUrl});

  static Doctor fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Doctor(
      name: data['name'],
      specialty: data['specialty'],
      distance: data['hospital'],
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }
}
