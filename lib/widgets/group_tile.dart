import 'package:chatapp_flutter/pages/chat.dart';
import 'package:chatapp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatefulWidget {
  final String groupName;
  final String groupId;
  final String userName;
  const GroupTile(
      {Key? key,
      required this.groupName,
      required this.groupId,
      required this.userName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}


class _GroupTileState extends State<GroupTile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.groupName);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        nextScreen(context, ChatePage(
          groupId: widget.groupId,
          groupName: widget.groupName,
          userName: widget.userName,
        ));
      },
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 5 , vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepOrangeAccent,
            child: Text(widget.groupName.substring(0, 1).toUpperCase(), textAlign: TextAlign.center,style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
          ),
          title: Text(widget.groupName, style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          subtitle: Text('Join the group as ${widget.userName}', style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),),

        ),
      ),
    );
  }
}
