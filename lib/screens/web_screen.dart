import 'dart:html';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebScreen extends StatefulWidget {
  WebScreen({Key? key, required this.url}) : super(key: key);
  String url;
  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  void _launchURL() async {
    if (!await launch(widget.url)) throw 'Could not launch ${widget.url}';
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _launchURL();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(),
    );
  }
}
