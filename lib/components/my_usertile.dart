import 'package:flutter/material.dart';

class MyUsertile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyUsertile({super.key, required this.text ,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color:Theme.of(context).colorScheme.tertiary
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //icon 
          Icon(Icons.person),
          SizedBox(width: 22,),
          //user name
          Text(text , style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.secondary),)
        ],
      ),
      ),
    );
  }
}
