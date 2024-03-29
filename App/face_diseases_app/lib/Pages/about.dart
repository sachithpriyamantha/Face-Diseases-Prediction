import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'About',
          style: TextStyle(
          color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 22, 0, 147),
      ),


      body: SingleChildScrollView(
        // Allows for scrolling
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
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'image/aboutus.png',

                          // Add an image related to your app or company
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 212, 80, 80),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Welcome to Face Diseases Prediction System, a dedicated platform committed to raising awareness, providing support, and fostering understanding about facial diseases. Our mission is to empower individuals affected by facial conditions, as well as their families and caregivers, by offering reliable information, resources, and a supportive community.',
                          style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 14,
                          height: 1.4, // Line spacing
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Our Vision',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 212, 80, 80),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'At Face Diseases Prediction System, we envision a world where individuals facing facial diseases can live life to the fullest, free from stigma and with access to the necessary support and resources for their unique journey.',
                            style: TextStyle(
                            //fontWeight: FontWeight.bold,
                              fontSize: 14,
                              height: 1.4, // Line spacing
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Our mission',
                              style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 212, 80, 80),
                              ),
                            ),
                            SizedBox(
                              height: 10
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4, // Line spacing
                                    color: Colors.black, // Default text color
                                    ),

                                    /**************************************mission details************************************************/
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
                                  ),
                                  
                                  SizedBox(height: 20),
                                  // Optionally, add more sections or contact info
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
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5, // Line spacing
                                      color: Colors.black, // Default text color, ensure this matches your theme
                                      ),
                                      
                                      /********************************Contact Info*************************************/
                                      children: <TextSpan>[
                                        TextSpan(text: 'Email: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        TextSpan(text: 'sachithpriyamantha@gmail.com\n', style: TextStyle(fontWeight: FontWeight.normal)),
                                        TextSpan(text: 'Website: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        TextSpan(text: 'www.facial_diseases.com\n', style: TextStyle(fontWeight: FontWeight.normal)),
                                        TextSpan(text: 'Mobile: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        TextSpan(text: '0752875365', style: TextStyle(fontWeight: FontWeight.normal)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }
