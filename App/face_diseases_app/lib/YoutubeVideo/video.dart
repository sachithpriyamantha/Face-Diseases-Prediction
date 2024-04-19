/*import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> addOrUpdateVideo(YoutubeVideo video) async {
    if (video.id.isEmpty) {
      // Add new video
      await videoCollection.add(video.toMap());
    } else {
      // Update existing video
      await videoCollection.doc(video.id).update(video.toMap());
    }
  }
}

*/