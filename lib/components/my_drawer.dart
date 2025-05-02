import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  void Function()? logout;
  void Function()? home;
  void Function()? setting;


   MyDrawer({super.key,required this.logout,required this.home, required this.setting});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 250,
                child: Icon(
                  Icons.message,
                  size: 50,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: ListTile(
                  selectedColor: Colors.red,
                  //shape: Border.all(),
                  hoverColor: Colors.red,
                  onTap: home,

                  leading: Icon(
                    Icons.home,
                    size: 24,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    "H O M E",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: ListTile(
              
                  onTap: setting,

                  leading: Icon(
                    Icons.settings,
                    size: 24,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    "S E T T I N G",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),

          //DrawerHeader(decoration: BoxDecoration(),child: Icon(Icons.home, size: 50, color: Theme.of(context).colorScheme.secondary,)),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 25),
                child: ListTile(
                  selectedColor: Colors.red,
                  //shape: Border.all(),
                  hoverColor: Colors.red,
                  onTap: logout,
                  leading: Icon(
                    Icons.logout,
                    size: 24,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    "L O G O U T ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
