import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/auth/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  final String recivedemail;
  final String recivedeid;

  const Chatpage({
    super.key,
    required this.recivedemail,
    required this.recivedeid,
  });

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  // text controller
  final TextEditingController _controller = TextEditingController();

  // chat & auth
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // focus mode
  FocusNode myFocosnode = FocusNode();
  @override
  void initState() {
    // add a listener to my focus mode
    myFocosnode.addListener(() {
      if (myFocosnode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scroldown());
      }
    });
    // wait a bit for listview  to be build  then scrol down
    Future.delayed(const Duration(milliseconds: 500), () => scroldown());
  }

  @override
  void dispose() {
    myFocosnode.dispose();
    _controller.dispose();
    super.dispose();
  }

  //send message
  void sendmessage() async {
    // if there is something inside text field
    if (_controller.text.isNotEmpty) {
      await _chatService.sendMessage(widget.recivedeid, _controller.text);
      // clear text ifeld
      _controller.clear();
    }
    scroldown();
  }

  // scroll controlleer
  final ScrollController _scrollController = ScrollController();
  scroldown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.recivedemail,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),

      body: Column(
        children: [Expanded(child: _buildMessagelist()), _buildUserInput()],
      ),
    );
  }

  Widget _buildMessagelist() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.recivedeid, senderID),
      builder: (context, snapshot) {
        // errr
        if (snapshot.hasError) {
          return Text("err");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("loading");
        }
        //eturn list view
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //is current user
    bool isCurrentuser = data["senderID"] == _authService.getCurrentUser()!.uid;
    //align message to the right
    var alignment =
        isCurrentuser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        mainAxisAlignment:
            isCurrentuser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentuser: isCurrentuser),
        ],
      ),
    );
  }

  // build a message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              focusnode: myFocosnode,
              hinttext: 'TYpe a message !!',
              controller: _controller,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendmessage,
              icon: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
