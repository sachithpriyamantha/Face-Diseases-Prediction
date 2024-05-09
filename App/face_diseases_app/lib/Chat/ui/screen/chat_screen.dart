
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_diseases_app/Chat/ui/widgets/message.dart';
import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Chat extends StatefulWidget {
  static const String id = "Chat";
  final User user;

  const Chat({Key? key, required this.user}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final CollectionReference _messageCollectionRef =
      FirebaseFirestore.instance.collection('messages');

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        ),
      ),
      title: const Text('Group Chat', style: TextStyle(color: Colors.white)),
      backgroundColor: Color.fromARGB(255, 99, 172, 143),
    ),





      /***************************************Body****************************************************************** */
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
        
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _messageCollectionRef.orderBy('date', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                  return ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var data = doc.data() as Map<String, dynamic>;

                      return Message(
                        from: data['from'] ?? 'Unknown',
                        text: data['text'],
                        imageUrl: data['imageUrl'],
                        me: widget.user.email == data['from'],
                      );
                    },
                  );
                },
              ),
            ),




                

            _buildInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.image),
            onPressed: _pickImage,
            color: Colors.blue,
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _sendMessage(text: messageController.text),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _uploadImage(File(image.path));
    }
  }

  Future<void> _uploadImage(File image) async {
    String fileName = Uuid().v1();
    var storageRef =
        FirebaseStorage.instance.ref().child("chat_images/$fileName");

    try {
      await storageRef.putFile(image);
      String downloadURL = await storageRef.getDownloadURL();
      _sendMessage(imageUrl: downloadURL);
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<void> _sendMessage({String? text, String? imageUrl}) async {
    final messageData = {
    'from': widget.user.email,
    'date': DateTime.now().toIso8601String(),
    'status': 'sent',
    
    if (text?.isNotEmpty ?? false) 'text': text,
    if (imageUrl != null) 'imageUrl': imageUrl,
    };

    await _messageCollectionRef.add(messageData);
    messageController.clear();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 100,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}