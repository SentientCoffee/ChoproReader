import "package:flutter/material.dart";

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("Exiting settings"); // @Temporary
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Center(
          child: Text("@Incomplete"), // @Incomplete
        ),
      ),
    );
  }
}
