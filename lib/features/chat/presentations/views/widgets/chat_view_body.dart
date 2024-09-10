import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart'; // Add this import for unique ID generation

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  // Load messages from Firestore
  void _loadMessages() {
    messages
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _messages.clear(); // Clear current messages to avoid duplication
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          _messages.add(
            types.TextMessage(
              id: doc.id,
              text: data['message'],
              author: types.User(id: data['authorId']),
              createdAt: data['createdAt'],
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/chat.png'),
              radius: 21,
            ),
            SizedBox(width: 10),
            Text(
              'Chat',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }

  // Add message to local state and Firestore
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });

    // Add message to Firestore
    messages.add({
      'message': (message as types.TextMessage).text,
      'createdAt': message.createdAt,
      'authorId': message.author.id,
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(), // Generate a unique ID for each message
      text: message.text,
    );

    _addMessage(textMessage);
  }
}
