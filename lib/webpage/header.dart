// ignore: file_names
import 'package:flutter/material.dart';

AppBar headerNav(BuildContext context) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white, size: 40),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: const Text("Erfolgreich Investieren in 4 Schritten"),
    //leading: Image.asset('web/images/Kapitalkopf.png', fit: BoxFit.fill),
    centerTitle: true,
    actions: const [
      /*IconButton(
          icon: const Icon(FontAwesomeIcons.youtube,
              color: Colors.red, size: 30.0),
          onPressed: () {
            js.context.callMethod('open',
                ['https://www.youtube.com/channel/UCYMfu0xZgSTiNLjJLQ9zJhA']);
          }),
      IconButton(
          icon: const Icon(FontAwesomeIcons.twitter,
              color: Colors.blueAccent, size: 30.0),
          onPressed: () {
            js.context.callMethod('open', ['https://twitter.com/kapitalkopf']);
          }),
      IconButton(
          icon: const Icon(FontAwesomeIcons.instagram,
              color: Colors.purpleAccent, size: 30.0),
          onPressed: () {
            js.context
                .callMethod('open', ['https://www.instagram.com/kapitalkopf/']);
          }),
      SizedBox(
        width: 10,
      ),*/
    ],
    actionsIconTheme: const IconThemeData(
      size: 32,
    ),
  );
}
/*
Drawer drawerX(BuildContext context) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: Container(
      width: 50,
      color: Colors.white,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,

        children: [
          ListTile(
              title: const Text(
                "Geldfluss",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Start()),
                    )
                  },
              tileColor: Colors.blue),
          ListTile(
              title: const Text("Geld verdienen"),
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Verdienen()),
                    )
                  },
              onLongPress: () => {},
              tileColor: Colors.blue),
          ListTile(
              title: const Text("Geld sparen"),
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Sparen()),
                    )
                  },
              onLongPress: () => {},
              tileColor: Colors.blue),
          ListTile(
              title: const Text("Geld anlegen"),
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Anlegen()),
                    )
                  },
              onLongPress: () => {},
              tileColor: Colors.blue),
          ListTile(
              title: const Text("BLOG"),
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Blog()),
                    )
                  },
              onLongPress: () => {},
              tileColor: Colors.blue),
          ListTile(
              title: const Text("Zu mir"),
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Whoami()),
                    )
                  },
              onLongPress: () => {},
              tileColor: Colors.blue),
        ],
      ),
    ),
  );
}*/
