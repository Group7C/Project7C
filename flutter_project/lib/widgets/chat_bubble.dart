import 'package:chat_app_2/models/chat_message_entity.dart';
import 'package:chat_app_2/services/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity entity;
  final Alignment alignment;


  const ChatBubble({Key? key, required this.alignment, required this.entity})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    bool isAuther = entity.author.userName ==context.read<AuthService>().getUserName();
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width*0.7
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${entity.text}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            if(entity.imageUrl!=null)
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image:
                    DecorationImage(image: NetworkImage(entity.imageUrl!)),
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.1)),
              )
          ],
        ),
        margin: EdgeInsets.all(10),
        decoration: isAuther


        ?BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),)
        )
        :BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
      bottomRight: Radius.circular(12),)
    ),
      ),
    );
  }
}