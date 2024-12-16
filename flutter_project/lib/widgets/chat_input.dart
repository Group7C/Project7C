import 'package:chat_app_2/models/chat_message_entity.dart';
import 'package:chat_app_2/services/Auth_Service.dart';
import 'package:chat_app_2/widgets/picker_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;
  ChatInput({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  String _selectedImageUrl = '';

  final chatMessageController = TextEditingController();

  Future<void> onSendButtonPressed() async {
    String? userNameFromCache = await context.read<AuthService>().getUserName();
    print('ChatMessage: ${chatMessageController.text}');
    final newChatMessage = ChatMessageEntity(
        text: chatMessageController.text,
        id: '99',
        createdAt: DateTime.now().microsecondsSinceEpoch,
        author: Author(userName: userNameFromCache!));
    if(_selectedImageUrl.isNotEmpty){
      newChatMessage.imageUrl = _selectedImageUrl;
    }

    widget.onSubmit(newChatMessage);
    chatMessageController.clear();
    _selectedImageUrl = '';
    setState(() {

    });
  }

  void onImagePicked(String newImageUrl){
    setState(() {
      _selectedImageUrl = newImageUrl;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(context: context, builder:(BuildContext context){
                return NetworkImagePickerBody(onImageSelected: onImagePicked ,);
              });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    minLines: 1,
                    controller: chatMessageController,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Type your message",
                        hintStyle: TextStyle(color: Colors.blueGrey),
                        border: InputBorder.none),
                  ),
                  if(_selectedImageUrl.isNotEmpty)
                    Image.network(_selectedImageUrl,height: 50,)
                ],
              )),
          IconButton(
            onPressed: onSendButtonPressed,
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    );
  }
}