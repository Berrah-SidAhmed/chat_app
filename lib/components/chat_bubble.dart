import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentuser;
  const ChatBubble({super.key, required this.message , required this.isCurrentuser });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isCurrentuser ? Theme.of(context).colorScheme.tertiary : Colors.green,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
    );
  }
}
