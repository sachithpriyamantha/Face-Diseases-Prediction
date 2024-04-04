/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('messages').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSentMessage = message['senderId'] == 'unique_sender_id'; // Replace 'unique_sender_id' with the actual sender's ID
                    return Align(
                      alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSentMessage ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isSentMessage ? 'You' : message['senderName'], // Display 'You' for sent messages, otherwise display sender's name
                              style: TextStyle(
                                fontWeight: isSentMessage ? FontWeight.bold : FontWeight.normal, // Bold style for sent messages
                                color: isSentMessage ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              message['message'],
                              style: TextStyle(
                                color: isSentMessage ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({
        'senderId': 'unique_sender_id', // Replace 'unique_sender_id' with the actual sender's ID
        'senderName': 'name', // Replace 'Your Name' with the actual sender's name
        'message': messageText,
        'timestamp': Timestamp.now(),
      });
      _messageController.clear();
    }
  }
}*/










/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text('No user is logged in'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('messages').orderBy('timestamp', descending: true).snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (ctx, index) {
                    final messageData = messages[index].data() as Map<String, dynamic>;
                    return MessageBubble(
                      message: messageData['message'],
                      username: messageData['senderName'], // Display sender name
                      key: ValueKey(messages[index].id),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Send a message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(user),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(User user) {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({
        'message': messageText,
        'senderId': user.uid,
        'senderName': user.email, // Using email as the sender name
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.username,
  }) : super(key: key);

  final String message;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              username,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
*/
