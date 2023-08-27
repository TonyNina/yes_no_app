import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/config/presentation/provides/chat_provider.dart';
import 'package:yes_no_app/config/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/config/presentation/widgets/chat/shared/message_field_box.dart';
import 'package:yes_no_app/domain/entities/message.dart';

import '../../widgets/chat/her_message_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(3.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://m.media-amazon.com/images/M/MV5BYWQwMjJmMWUtYjI2Ny00NjI4LTg4ZmQtOGMwM2UyNTZhZDBkXkEyXkFqcGdeQXVyMTAwODQyMDE1._V1_.jpg'),
          ),
        ),
        centerTitle: true,
        title: const Text('Mi amor 😍'),
      ),
      body: _ChatView(), //Como un div,
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

 final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(

                    controller: chatProvider.chatScrollController,

                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messageList[index];

                      return (message.fromWho == FromWho.hers)
                      ? HerMessageBubble( message: message)
                      : MyMessageBubble( message: message );

                    },)),

            ///Caja de texto de mensajes
            MessageFieldBox(
              //onValue: (value) => chatProvider.sendMessage(value),
              onValue: chatProvider.sendMessage,
            ),
           
          ],
        ),
      ),
    );
  }
}
