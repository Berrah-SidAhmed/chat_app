import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_btn.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class Login extends StatelessWidget {
  final void Function()? ontap;
  Login({super.key, required this.ontap});

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();
  login(context) async {
    //auth
    final authService = AuthService();
    // try login
    try {
      await authService.signInWithEmailPassword(
        emailcontroller.text,
        pwcontroller.text,
      );
    } catch (e) {
      showDialog( 
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(e.toString()),
          );
        },
      );
    }
    // catch err
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              IconlyBroken.profile,
              size: 50,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(height: 40),
            //  text like welcom to my app just log in
            Text(
              "Good to see you! Enter your information to continue.",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            SizedBox(height: 40),

            // email textfield
            MyTextfield(hinttext: "Email", controller: emailcontroller),

            // pw textfield
            MyTextfield(hinttext: "Password", controller: pwcontroller),
            // botoun for login
            MyBtn(onTap: ()=> login(context), text: "Login"),
            SizedBox(height: 30),

            // if u dont have acount just register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New here? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    "Create an account.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
