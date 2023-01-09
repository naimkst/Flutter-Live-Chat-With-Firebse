import 'package:flutter/material.dart';

class ChatePage extends StatefulWidget {
  final String? groupId;
  final String? groupName;
  final String? userName;
  const ChatePage(
      {Key? key,
      required this.userName,
      required this.groupName,
      required this.groupId})
      : super(key: key);

  @override
  State<ChatePage> createState() => _ChatePageState();
}

class _ChatePageState extends State<ChatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.groupName.toString()),
      ),
    );
  }
}
