
import 'dart:convert';
import 'package:chat_app_2/models/chat_message_entity.dart';
import 'package:chat_app_2/repo/image_repositry.dart';
import 'package:chat_app_2/services/Auth_Service.dart';
import 'package:chat_app_2/widgets/chat_bubble.dart';
import 'package:chat_app_2/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'models/image_model.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageEntity> _messages = [];




  _loadInitialMessages() async{
    rootBundle.loadString('assets/mock_messages.json').then((response){
      final List<dynamic> decodedList = jsonDecode(response) as List;
      final List<ChatMessageEntity> _chatMessages =decodedList.map((listItem){
        return ChatMessageEntity.fromJson(listItem);
      }).toList();

      setState(() {
        _messages = _chatMessages;
      });
    });

  }

  onMessageSent(ChatMessageEntity entity){
    _messages.add(entity);
    setState(() {});
  }
//"https://picsum.photos/v2/list"




  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi $username!'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthService>().logOutUser();
                Navigator.pushReplacementNamed(context, '/');
                print('Icon pressed!');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                        alignment: _messages[index].author.userName == context.read<AuthService>().getUserName()
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        entity: _messages[index]
                    );
                  })
          ),
          ChatInput(onSubmit:onMessageSent ,),
        ],
      ),
    );
  }
}