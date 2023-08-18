import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BasicFirestoreReadScreen extends StatefulWidget {
  @override
  _BasicFirestoreReadScreenState createState() => _BasicFirestoreReadScreenState();
}

class _BasicFirestoreReadScreenState extends State<BasicFirestoreReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Firestore Read'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _fetchSingleTopic(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Display fetched topic data
              var topicData = snapshot.data;
              String topicTitle = topicData?['title'] ?? 'No title available';
              String topicImage = topicData?['img'] ?? 'No image available';
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Topic Title: $topicTitle'),
                  Text('Topic Image: $topicImage'),
                ],
              );
            } else {
              return Text('No data available.');
            }
          },
        ),
      ),
    );
  }

  Future<DocumentSnapshot> _fetchSingleTopic() async {
    // Replace 'documentId' with the actual ID of the document you want to fetch
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('my-topics')
        .doc('data-protection-topic')
        .get();
    return snapshot;
  }
}
