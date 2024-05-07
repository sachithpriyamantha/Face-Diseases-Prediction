/*import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideo {
  final String title;
  final String videoId;
  final String thumbnailUrl; // Added thumbnail URL

  YoutubeVideo({
    required this.title,
    // Youtube Video Id
    required this.videoId,
    // Initialize thumbnail URL
    required this.thumbnailUrl,
  }
);
}

// Sample list of videos with added thumbnails
List<YoutubeVideo> youtubeVideos = [
    YoutubeVideo(
    title: "Acne Vulgaris |Diagnosis, Treatment and Complications",
    videoId: "JPz1v_TrC0o", //  video IDs
    thumbnailUrl: "https://img.youtube.com/vi/JPz1v_TrC0o/0.jpg", // thumnail URI
  ),
  YoutubeVideo(
    title: "What is Eczema? Diagnosis and TreatmentWhat is Eczema? Diagnosis and Treatment.",
    videoId: "fmurdUlmaIg",
    thumbnailUrl: "https://img.youtube.com/vi/fmurdUlmaIg/0.jpg",
  ),
  YoutubeVideo(
    title: "Apitoc Triad, Triggers, Who gets it, Why does it happen & Treatment",
    videoId: "nQfGPoUcgvU",
    thumbnailUrl: "https://img.youtube.com/vi/nQfGPoUcgvU/0.jpg",
  ),
  YoutubeVideo(
    title: "Explaining Seborrheic Keratosis | With Dr O'Donovan",
    videoId: "F9poOGHuqiM",
    thumbnailUrl: "https://img.youtube.com/vi/F9poOGHuqiM/0.jpg",
  ),
  YoutubeVideo(
    title: "(Tinea Corporis) |Risk Factors, Diagnosis and Treatment",
    videoId: "GpG22UKhMNw",
    thumbnailUrl: "https://img.youtube.com/vi/GpG22UKhMNw/0.jpg",
  ),
  YoutubeVideo(
    title: "Pharmacology - ACNE TREATMENTS (MADE EASY)",
    videoId: "zxWh-7IC7HY",
    thumbnailUrl: "https://img.youtube.com/vi/zxWh-7IC7HY/0.jpg",
  ),
  YoutubeVideo(
    title: "Kaitlin Vaughn, PA - Actinic-Keratoses (AKs)....",
    videoId: "d1bX0_FqYIE",
    thumbnailUrl: "https://img.youtube.com/vi/d1bX0_FqYIE/0.jpg",
  ),
  YoutubeVideo(
    title: " Symptoms & Homeopathic Management",
    videoId: "5bLXJUjKVEA",
    thumbnailUrl: "https://img.youtube.com/vi/5bLXJUjKVEA/0.jpg",
  ),
];

class YoutubeVideoListScreen extends StatelessWidget {
  final List<YoutubeVideo> videos;

  YoutubeVideoListScreen({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'PlayList',
          style: TextStyle(
          color: Colors.white,
          ),
          ),
          backgroundColor: Color.fromARGB(255, 22, 0, 147),
      ),


      /*body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5, // Added elevation for better visual hierarchy
            margin: EdgeInsets.all(10),// Added margin for spacing
            color: const Color.fromARGB(255, 170, 178, 185),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YoutubePlayerScreen(videoId: videos[index].videoId),
                  ),
                );
              },
              leading: Image.network(
                videos[index].thumbnailUrl,
                width: 100,
                height: 60,
                fit: BoxFit.cover,), // Display thumbnail
              title: Text(
                videos[index].title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.play_circle_fill, color: Color.fromARGB(255, 17, 48, 187),), // Play icon
            ),
          );
        },
      ),*/


      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100, // Set the desired height for the card
            
            child: Card(
              elevation: 5, // Added elevation for better visual hierarchy
              margin: EdgeInsets.all(8), // Added margin for spacing
              color: const Color.fromARGB(255, 170, 178, 185),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YoutubePlayerScreen(
                        videoId: videos[index].videoId
                        ),
                      ),
                    );
                  },
                      
                    /* leading: Image.network(
                        videos[index].thumbnailUrl,
                        width: 100,
                        height: 60,
                        fit: BoxFit.cover, // Display thumbnail
                        ), */

                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0), // Set the corner radius here
                          child: Image.network(
                          videos[index].thumbnailUrl,
                          width: 100,
                          height: 60,
                          fit: BoxFit.cover, // Display thumbnail
                          ),
                        ),

                        
                        title: Text(
                          videos[index].title,
                          style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          ),
                          ),
                          
                          trailing: Icon(
                            Icons.play_circle_fill,
                            color: Color.fromARGB(255, 147, 41, 204),
                            ), // Play icon
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }

class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;

  YoutubePlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }




    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Youtube Video',
          style: TextStyle(
          color: Colors.white,
          ),
        ),
      backgroundColor: Color.fromARGB(255, 22, 0, 147),
    ),



    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          
        ),
        SizedBox(height: 0),
        Expanded(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.deepPurple,
          ),
        ),
      ],
    ),
  );
}
}
*/








import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideo {
  final String id;
  final String title;
  final String videoId;
  final String thumbnailUrl;

  YoutubeVideo({
    required this.id,
    required this.title,
    required this.videoId,
    required this.thumbnailUrl,
  });

  factory YoutubeVideo.fromDocument(DocumentSnapshot doc) {
    return YoutubeVideo(
      id: doc.id,
      title: doc['title'],
      videoId: doc['videoId'],
      thumbnailUrl: doc['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'videoId': videoId,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
class YoutubeVideoListScreen extends StatelessWidget {
  YoutubeVideoListScreen({Key? key, required videos}) : super(key: key);

  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('PlayList', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 99, 172, 143),
      ),
      body: StreamBuilder<List<YoutubeVideo>>(
        stream: _firestoreService.streamVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final videos = snapshot.data!;
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  color: Color.fromARGB(255, 170, 178, 185),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YoutubePlayerScreen(videoId: videos[index].videoId),
                        ),
                      );
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        videos[index].thumbnailUrl,
                        width: 100,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      videos[index].title,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.play_circle_fill, color: Color.fromARGB(255, 147, 41, 204)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
  
  //YoutubePlayerScreen({required String videoId}) {}
}
class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;

  YoutubePlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Youtube Video',
          style: TextStyle(
          color: Colors.white,
          ),
        ),
      backgroundColor: Color.fromARGB(255, 22, 0, 147),
    ),



    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          
        ),
        SizedBox(height: 0),
        Expanded(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.deepPurple,
          ),
        ),
      ],
    ),
  );
}
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<YoutubeVideo>> streamVideos() {
    return _db.collection('videos').snapshots().map((QuerySnapshot query) {
      List<YoutubeVideo> videos = [];
      for (var doc in query.docs) {
        videos.add(YoutubeVideo.fromDocument(doc));
      }
      return videos;
    });
  }

  getUsers() {}
}

