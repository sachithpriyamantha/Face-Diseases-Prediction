/*import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('About', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 22, 0, 147),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 114, 228, 215),
                Color.fromARGB(255, 197, 232, 93),
                Color.fromARGB(255, 114, 228, 215),
              ],
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildImageSection(),
              SizedBox(height: 20),
              buildTitleSection('About Us', Color.fromARGB(255, 212, 80, 80)),
              SizedBox(height: 10),
              buildParagraphSection('Welcome to Face Diseases Prediction System, a dedicated platform committed to raising awareness, providing support, and fostering understanding about facial diseases. Our mission is to empower individuals affected by facial conditions, as well as their families and caregivers, by offering reliable information, resources, and a supportive community.'),
              SizedBox(height: 20),
              buildTitleSection('Our Vision', Color.fromARGB(255, 212, 80, 80)),
              SizedBox(height: 10),
              buildParagraphSection('At Face Diseases Prediction System, we envision a world where individuals facing facial diseases can live life to the fullest, free from stigma and with access to the necessary support and resources for their unique journey.'),
              SizedBox(height: 20),
              buildTitleSection('Our Mission', Color.fromARGB(255, 212, 80, 80)),
              SizedBox(height: 10),
              buildMissionDetails(),
              SizedBox(height: 20),
              buildContactSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageSection() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'image/aboutus.png',
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildTitleSection(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget buildParagraphSection(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        height: 1.4,
      ),
    );
  }

  Widget buildMissionDetails() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14, height: 1.4, color: Colors.black),
        children: <TextSpan>[
          TextSpan(text: 'Raise Awareness: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'We strive to increase awareness and understanding of facial diseases among the general public, healthcare professionals, and policymakers.\n'),
          TextSpan(text: 'Provide Support: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'We offer a supportive community where individuals affected by facial conditions can connect, share experiences, and find comfort in knowing they are not alone.\n'),
          TextSpan(text: 'Educate and Inform: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Through accurate and up-to-date information, we aim to educate our community about various facial diseases, their causes, symptoms, and available treatment options.\n'),
          TextSpan(text: 'Advocate for Change: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'We advocate for policies and practices that promote inclusivity, accessibility, and equality for individuals affected by facial diseases.'),
        ],
      ),
    );
  }

  Widget buildContactSection() {
    return Column(
      children: [
        Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 212, 80, 80),
          ),
        ),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: 'Email: ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'sachithpriyamantha@gmail.com\n'),
              TextSpan(text: 'Website: ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'www.facial_diseases.com\n'),
              TextSpan(text: 'Mobile: ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '0752875365'),
            ],
          ),
        ),
      ],
    );
  }
}*/



import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
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
                    'Hi Sachith Priyamantha,\nWelcome to Face Guardian!',
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
              backgroundImage: AssetImage('image/about.png'), // Update with your asset path
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
