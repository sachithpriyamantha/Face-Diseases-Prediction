import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String? text;
  final String? imageUrl;
  final bool me;
  final String? status;

  const Message({
    Key? key,
    required this.from,
    this.text,
    this.imageUrl,
    required this.me,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    

    Color backgroundColor = me ? Color.fromARGB(255, 151, 229, 255) : Color.fromARGB(255, 230, 223, 255);
    Color textColor = me ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 0, 0, 0);

    return Align(
    
    
      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(from, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
            if (text != null && text!.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(text!, style: TextStyle(color: textColor)),
              ),
            if (imageUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Image.network(imageUrl!, width: 200, height: 200, fit: BoxFit.cover),
              ),
          ],
        ),
      ),
    );
  }
}