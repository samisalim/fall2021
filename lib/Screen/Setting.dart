import 'package:flutter/material.dart';
class Setting extends StatefulWidget {

  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Setting'),
      ),
    );
  }
}
