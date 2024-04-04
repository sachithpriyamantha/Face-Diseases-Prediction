//import 'package:face_diseases_app/ui/screen/home_screen.dart';
/*import 'package:face_diseases_app/Chat/ui/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

                  List<Widget> messages = docs
                      .map((doc) => Message(
                            from: doc.data()['from'],
                            text: doc.data()['text'],
                            me: widget.user.email == doc.data()['from'],
                          ))
                      .toList();

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
}
*/


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
