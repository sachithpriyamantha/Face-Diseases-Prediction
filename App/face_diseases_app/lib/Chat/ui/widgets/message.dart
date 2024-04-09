import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String? text;
  final String? imageUrl;
  final bool me;

  const Message({
    Key? key,
    required this.from,
    this.text,
    this.imageUrl,
    required this.me,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(from, style: TextStyle(fontWeight: FontWeight.bold)),
        if (text != null && text!.isNotEmpty) 
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(text!),
          ),
        if (imageUrl != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Image.network(imageUrl!, width: 200, fit: BoxFit.cover), // Adjust size as needed
          ),
      ],
    );
  }
}
