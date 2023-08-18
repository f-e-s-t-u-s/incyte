import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incyte/topics/topic_item.dart';

import '../services/firestore.dart';
import '../services/models.dart';
import '../shared/bottom_nav.dart';
import '../shared/error.dart';
import '../shared/loading.dart';
import 'drawer.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {


          // Show error message
          return const Center(
            child: ErrorMessage(),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text('Topics'),
              actions: [
                IconButton(
                  padding: const EdgeInsets.only(right: 16.0),
                  icon: const Icon(FontAwesomeIcons.circleUser),
                  color: Colors.deepOrange[400],
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ],
            ),
            drawer: TopicDrawer(topics: topics),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((e) => TopicItem(topic: e)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}

