import 'package:flutter/material.dart';

class AlertDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AlertDialogState();
}

class AlertDialogState extends State<AlertDialog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Note!")
      ),
    );
  }
}
