import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String text;

  final bool me;

    const Message({
    Key? key,
    required this.from,
    required this.text,
    required this.me,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment:
              me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              from,
            ),
            Material(
              color: me ? Colors.blueAccent : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(
                  text,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
