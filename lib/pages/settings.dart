import 'package:flutter/material.dart';

import '../assets/constants.dart';
import '../widgets/nav_drawer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Constants.lightRedColor,
      ),
      drawer: const NavDrawer(),
      body: Container(),
    );
  }
}
