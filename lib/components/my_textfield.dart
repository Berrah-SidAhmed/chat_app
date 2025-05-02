import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hinttext;
  final TextEditingController controller;
  final FocusNode? focusnode;
  const MyTextfield({super.key, required this.hinttext, required this.controller, this.focusnode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        focusNode: focusnode,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.tertiary,
          //focusColor: Theme.of(context).colorScheme.inversePrimary,
          hintText: hinttext,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
