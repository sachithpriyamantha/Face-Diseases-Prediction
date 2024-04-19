
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class YoutubeVideo {
  final String id;
  final String title;
  final String videoId;
  final String thumbnailUrl;

  YoutubeVideo({
    this.id = '',
    required this.title,
    required this.videoId,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'videoId': videoId,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory YoutubeVideo.fromMap(Map<String, dynamic> map, String documentId) {
    return YoutubeVideo(
      id: documentId,
      title: map['title'],
      videoId: map['videoId'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }
}

class DatabaseService {
  final CollectionReference videoCollection = FirebaseFirestore.instance.collection('videos');

  Stream<List<YoutubeVideo>> getVideos() {
    return videoCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => YoutubeVideo.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> addOrUpdateVideo(YoutubeVideo video) async {
    if (video.id.isEmpty) {
      await videoCollection.add(video.toMap());
    } else {
      await videoCollection.doc(video.id).update(video.toMap());
    }
  }

  Future<void> deleteVideo(String videoId) async {
    await videoCollection.doc(videoId).delete();
  }
}

class VideoManagementPage extends StatefulWidget {
  const VideoManagementPage({Key? key}) : super(key: key);

  @override
  _VideoManagementPageState createState() => _VideoManagementPageState();
}

class _VideoManagementPageState extends State<VideoManagementPage> {
  final DatabaseService _databaseService = DatabaseService();

  void _addOrEditVideo(BuildContext context, {YoutubeVideo? video}) {
    TextEditingController titleController = TextEditingController(text: video?.title ?? '');
    TextEditingController videoIdController = TextEditingController(text: video?.videoId ?? '');
    TextEditingController thumbnailUrlController = TextEditingController(text: video?.thumbnailUrl ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(video == null ? 'Add Video' : 'Edit Video'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: videoIdController, decoration: const InputDecoration(labelText: 'Video ID')),
              TextField(controller: thumbnailUrlController, decoration: const InputDecoration(labelText: 'Thumbnail URL')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              YoutubeVideo updatedVideo = YoutubeVideo(
                id: video?.id ?? '',
                title: titleController.text,
                videoId: videoIdController.text,
                thumbnailUrl: thumbnailUrlController.text,
              );
              _databaseService.addOrUpdateVideo(updatedVideo);
              Navigator.pop(context);
            },
            child: Text(video == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Videos')),
      body: StreamBuilder<List<YoutubeVideo>>(
        stream: _databaseService.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching videos'));
          }
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No videos found'));
          }
          return ListView(
            children: snapshot.data!.map((video) {
              return ListTile(
                title: Text(video.title),
                subtitle: Text(video.videoId),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _addOrEditVideo(context, video: video),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _databaseService.deleteVideo(video.id),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditVideo(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: VideoManagementPage(),
    debugShowCheckedModeBanner: false,
  ));
}
