import 'package:chat_app/theme/dark_mode.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar:  AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text("H O M E ", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
    ),
      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //text
            Text("D A R K M O D E"),
            // cuppertino switch
            CupertinoSwitch(
              value:
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).themeData ==
                  darkMode,
              onChanged:
                  (value) =>
                      Provider.of<ThemeProvider>(
                        context,
                        listen: false,
                      ).toggletheme(),
            ),
          ],
        ),
      ),
    );
  }
}
