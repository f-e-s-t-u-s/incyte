/*
* File : Personal Information Form
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:incyte/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/bottom_nav.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotline Numbers',
      theme: appTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // Index of the currently selected tab

  final List<Widget> _tabs = [
    HotlineList(),
    // Add more tabs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotline Numbers'),
      ),
      body: _tabs[_currentIndex], // Display the currently selected tab
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class HotlineList extends StatelessWidget {
  final List<Map<String, String>> hotlineNumbers = [
    {'name': 'Healthcare Assistance', 'number': '1195'},
    {'name': 'Police', 'number': '999'},
    {'name': 'Fire Department', 'number': '0202344599'},
    {'name': 'Gender Based Violence' , 'number':'0719638006'},
    {'name': 'Childline Kenya', 'number':'116'}
    // Add more hotline numbers here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hotlineNumbers.length,
      itemBuilder: (ctx, index) {
        final hotline = hotlineNumbers[index];
        return ListTile(
          title: Text(hotline['name']!),
          subtitle: Text(hotline['number']!),
          onTap: () {
            _launchURL('tel:${hotline['number']}');
          },
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
