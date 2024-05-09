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
      backgroundColor: Color.fromARGB(255, 243, 246, 244),
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
                  color: Color.fromARGB(255, 203, 206, 209),
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
                    trailing: Icon(Icons.play_circle_fill, color: Color.fromARGB(255, 193, 30, 30)),
                  ),
                ),
              );
            },
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

