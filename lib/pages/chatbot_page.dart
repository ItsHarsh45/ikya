import 'package:flutter/material.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<Map<String, dynamic>> messages = [
    {"message": "I have some creative energy to share. How about we brainstorm some ideas for your next writing project?", "isBot": true},
    {"message": "I'm working on a short story but I'm a bit stuck. Do you have any ideas for an intriguing plot?", "isBot": false},
    {"message": "How about a story where the main character discovers an old diary that reveals secrets about their family's past? Each entry in the diary could lead to a new mystery or adventure they need to solve.", "isBot": true},
    {"message": "That's an interesting premise. What kind of setting do you think would work well for this story?", "isBot": false},
    {"message": "Here's 10 ideas for a setting", "isBot": true},
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      children: [
        // Title section with image/logo and text
        const Padding(
          padding: EdgeInsets.only(top: 60, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
                radius: 20,
              ),
              SizedBox(width: 10),
              Text(
                "EchoBuddy",  // Fancy bot name
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Expanded chat area
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[messages.length - 1 - index];
              return Align(
                alignment: message["isBot"]
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message["isBot"]
                        ? Colors.grey[200]
                        : Colors.purple[200],  // Changed to purple for user messages
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    message["message"],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),

        // Input bar above the navbar
        Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 10.0,  // Added space at the top
            bottom: keyboardHeight + 10,  // Adjust based on keyboard height
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    fillColor: Colors.white,  // White background for the input bar
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.purple),  // Changed to purple
                onPressed: () {
                  setState(() {
                    if (_controller.text.isNotEmpty) {
                      messages.add({
                        "message": _controller.text,
                        "isBot": false,
                      });
                      _controller.clear();
                      // Scroll to the bottom after sending a message
                      _scrollController.animateTo(
                        0.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
