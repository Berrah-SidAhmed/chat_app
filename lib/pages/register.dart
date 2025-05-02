import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_btn.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({super.key, required this.ontap});
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();
  TextEditingController confirmpwcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  final void Function()? ontap;
  void registre(context) {
    // get auth
    final auth = AuthService();

    ///
    if (pwcontroller.text == confirmpwcontroller.text) {
      try {
        auth.signUpWithEmailPassword(emailcontroller.text, pwcontroller.text ,usernamecontroller.text );
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
    }else{
        showDialog( 
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Passwords do not match. Please try again."),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                IconlyBroken.add_user,
                size: 50,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(height: 40),
              //  text like welcom to my app just log in
              Text(
                "We’re excited to have you! Create your account below.”",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(height: 40),
                // username
                  MyTextfield(hinttext: "username", controller: usernamecontroller),
              // email textfield
              MyTextfield(hinttext: "Email", controller: emailcontroller),
              
              // pw textfield
              MyTextfield(hinttext: "Password", controller: pwcontroller),
              // confirme pw textfield
              MyTextfield(
                hinttext: "Confirme Password",
                controller: confirmpwcontroller,
              ),
              
              // botoun for login
              MyBtn(onTap: () => registre(context), text: "Register"),
              SizedBox(height: 30),
              
              // if u dont have acount just register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?  ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: ontap,
                    child: Text(
                      "Log In",
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
      ),
    );
  }
}
