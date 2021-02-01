import 'package:flutter/material.dart';

class PodCastPage extends StatefulWidget {
  @override
  _PodCastPageState createState() => _PodCastPageState();
}

class _PodCastPageState extends State<PodCastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('PodCast PAGE', style: TextStyle(
          color: Colors.red
        ),),
      ),
    );
  }
}