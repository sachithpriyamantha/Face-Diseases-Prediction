//import 'package:face_diseases_app/ui/screen/home_screen.dart';
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_diseases_app/Chat/ui/widgets/message.dart';
import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  static const String id = "Chat";
  final User user;

  const Chat({required Key key, required this.user}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  CollectionReference _messageCollectionRef =
      FirebaseFirestore.instance.collection('messages');
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(60),
              child: RaisedButton(
                child: Text("Log out"),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Dashboard()));
                },
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _messageCollectionRef.orderBy('date').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  List<DocumentSnapshot> docs = snapshot.data!.docs;

                  List<Widget> messages = docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>?;
                    // Use `?.` to safely access the properties, providing a fallback value if null
                    final from = data?['from'] ?? 'Unknown';
                    final text = data?['text'] ?? 'No message text.';
                    return Message(
                      from: from,
                      text: text,
                      me: widget.user.email == from,
                    );
                  }).toList();

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
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
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: () {},
                // getImage,
                color: Colors.blue,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
                controller: messageController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => callback(),
                color: Colors.grey,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      _messageCollectionRef.add({
        'text': messageController.text,
        'from': widget.user.email,
        'date': DateTime.now().toIso8601String().toString(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  RaisedButton({required Text child, required Null Function() onPressed}) {}
}*/

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_diseases_app/Chat/ui/widgets/message.dart'; // Ensure this path is correct
import 'package:face_diseases_app/Pages/dashboard.dart'; // Ensure this path is correct
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu'),
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () async {
                await _auth.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard())); // Make sure Dashboard is your desired landing page after logout
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Group Chat"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _messageCollectionRef.orderBy('date').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                  List<DocumentSnapshot> docs = snapshot.data!.docs;
                  List<Widget> messages = docs
                      .map((doc) {
                        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
                        if (data != null) {
                          return Message(
                            from: data['from'],
                            text: data['text'],
                            me: widget.user.email == data['from'],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      })
                      .toList();

                  return ListView(
                    controller: scrollController,
                    children: messages,
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
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)), color: Colors.white),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              // Implement your image sending functionality here
            },
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
            onPressed: callback,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Future<void> callback() async {
    if (messageController.text.isNotEmpty) {
      await _messageCollectionRef.add({
        'text': messageController.text,
        'from': widget.user.email,
        'date': DateTime.now().toIso8601String(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }
}

*/

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_diseases_app/Chat/ui/widgets/message.dart'; // Ensure this path is correct
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
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
    onPressed: () => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    ),
  ),
  title: Text(
    'Group Chat',
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Color.fromARGB(255, 22, 0, 147),
),





      /***************************************Body****************************************************************** */
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
        
Expanded(
  child: StreamBuilder<QuerySnapshot>(
    stream: _messageCollectionRef.orderBy('date').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

      // Ensuring docs is never null
      List<DocumentSnapshot> docs = snapshot.data?.docs ?? [];

      // Initializing messages as an empty list to ensure it's not null
      List<Widget> messages = [];

      // Safely iterate over docs and build your widgets
      if (docs.isNotEmpty) {
        messages = docs.map((doc) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          // Ensure data is not null before proceeding
          if (data != null) {
            return Message(
              from: data['from'] ?? 'Unknown',
              text: data['text'] ?? '',
              imageUrl: data['imageUrl'], // Assuming Message widget can handle nullable imageUrl
              me: widget.user.email == data['from'],
              status: data['status'] ?? 'sent', // Handling status
            );
          } else {
            // Returning a placeholder or empty widget if data is null
            return SizedBox.shrink();
          }
        }).toList();
      }

      return ListView(
        controller: scrollController,
        children: messages,
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
    'status': 'sent', // Initial status of the message
    // Add text and imageUrl if they are not null
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
