import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/my_usertile.dart';
import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/pages/setting.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/auth/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  // chat and auth servesic
  final chatService = ChatService();
  final authservices = AuthService();

  //drwer
  void logout() {
    final auth = AuthService();
    auth.signout();
  }

  void setting() {
    Navigator.of(context).pop;
    Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      drawer: MyDrawer(
        setting: setting,
        home: Navigator.of(context).pop,
        logout: logout,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "H O M E ",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),

      body: StreamBuilder(
        stream: chatService.getUserStream(),
        builder: (context, snapshot) {
          //err
          if (snapshot.hasError) {
            return Text("err");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading");
          }
          //eturn list view
          return ListView(
            children:
                snapshot.data!
                    .map<Widget>(
                      (userData) => _buildUserListview(userData, context),
                    )
                    .toList(),
          );
        },
      ),
    );
  }

  Widget _buildUserListview(
    Map<String, dynamic> userData,
    BuildContext Context,
  ) {
    if (userData['email'] != authservices.getCurrentUser()!.email) {
      return MyUsertile(
        onTap: () {
          Navigator.push(
            Context,
            MaterialPageRoute(
              builder:
                  (context) => Chatpage(
                    recivedemail: userData["email"],
                    recivedeid: userData["uid"],
                  ),
            ),
          );
        },
        text: userData["username"],
      );
    } else {
      return Container();
    }

    //display
  }
}
