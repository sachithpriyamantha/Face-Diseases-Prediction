
// ignore_for_file: file_names
/*
import 'package:admin/YoutubeVideo/video.dart';
import 'package:flutter/material.dart';


class AddVideoForm extends StatefulWidget {
  final YoutubeVideo? video;

  const AddVideoForm({super.key, this.video});

  @override
  // ignore: library_private_types_in_public_api
  _AddVideoFormState createState() => _AddVideoFormState();
}

class _AddVideoFormState extends State<AddVideoForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _videoIdController;
  late TextEditingController _thumbnailUrlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.video?.title ?? '');
    _videoIdController = TextEditingController(text: widget.video?.videoId ?? '');
    _thumbnailUrlController = TextEditingController(text: widget.video?.thumbnailUrl ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video == null ? "Add New Video" : "Edit Video"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
            ),
            TextFormField(
              controller: _videoIdController,
              decoration: const InputDecoration(labelText: 'Video ID'),
              validator: (value) => value!.isEmpty ? 'Please enter a video ID' : null,
            ),
            TextFormField(
              controller: _thumbnailUrlController,
              decoration: const InputDecoration(labelText: 'Thumbnail URL'),
              validator: (value) => value!.isEmpty ? 'Please enter a thumbnail URL' : null,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  YoutubeVideo video = YoutubeVideo(
                    id: widget.video?.id ?? '',
                    title: _titleController.text,
                    videoId: _videoIdController.text,
                    thumbnailUrl: _thumbnailUrlController.text,
                  );
                  await DatabaseService().addOrUpdateVideo(video);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Video'),
            ),
          ],
        ),
      ),
    );
  }
}

*/


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Define the YouTubeVideo model
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

// Define the DatabaseService class
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
}

// Define the AddVideoForm widget
class AddVideoForm extends StatefulWidget {
  final YoutubeVideo? video;

  const AddVideoForm({super.key, this.video});

  @override
  _AddVideoFormState createState() => _AddVideoFormState();
}

class _AddVideoFormState extends State<AddVideoForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _videoIdController;
  late TextEditingController _thumbnailUrlController;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.video?.title ?? '');
    _videoIdController = TextEditingController(text: widget.video?.videoId ?? '');
    _thumbnailUrlController = TextEditingController(text: widget.video?.thumbnailUrl ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video == null ? "Add New Video" : "Edit Video"),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                ),
                TextFormField(
                  controller: _videoIdController,
                  decoration: const InputDecoration(labelText: 'Video ID'),
                  validator: (value) => value!.isEmpty ? 'Please enter a video ID' : null,
                ),
                TextFormField(
                  controller: _thumbnailUrlController,
                  decoration: const InputDecoration(labelText: 'Thumbnail URL'),
                  validator: (value) => value!.isEmpty ? 'Please enter a thumbnail URL' : null,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      YoutubeVideo video = YoutubeVideo(
                        id: widget.video?.id ?? '',
                        title: _titleController.text,
                        videoId: _videoIdController.text,
                        thumbnailUrl: _thumbnailUrlController.text,
                      );
                      await _databaseService.addOrUpdateVideo(video);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Video'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<YoutubeVideo>>(
              stream: _databaseService.getVideos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching videos'));
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No videos found'));
                }
                return ListView(
                  children: snapshot.data!.map((video) {
                    return ListTile(
                      title: Text(video.title),
                      subtitle: Text(video.videoId),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _databaseService.addOrUpdateVideo(video),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
