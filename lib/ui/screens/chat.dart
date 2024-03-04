import 'package:chat_app/ui/widgets/chat_messages.dart';
import 'package:chat_app/ui/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  void setUpPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    // use token to send push notification to a particular device
    // use subscribeTopic to send notification to all connected devices

    // final token = await fcm.getToken();
    fcm.subscribeToTopic("chat");
  }

  @override
  void initState() {
    super.initState();

    setUpPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat Room"),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ],
        ),
        body: const Column(
          children: [Expanded(child: ChatMessages()), NewMessage()],
        ));
  }
}
