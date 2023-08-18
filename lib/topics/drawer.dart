import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../quiz/quiz.dart';
import '../services/models.dart';

class TopicDrawer extends StatelessWidget {
  final List <Topic> topics;
  const TopicDrawer({Key? key , required this.topics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ListView is scrollable
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: topics.length,
        //itembuilder main content of an individual item item = topic
        itemBuilder: (BuildContext context, int index) {
          Topic topic = topics[index];
          //Add the title i.e Angular
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10 , left:10),
                child: Text(
                  topic.title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
              QuizList(topic:topic),
            ],
          );
        },
        //adds a widget between the two items
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
          );
        },
      ),
    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({Key? key , required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  topic.quizzes.map(
            (quiz) {
          return Card(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 4,
            margin: const EdgeInsets.all(4),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => QuizScreen(quizId:quiz.id),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                //List Title is a rectangular has title subtitle  and leading widget perfect to put Icon on left side of list tile (show green checkmark completed quiz)
                child: ListTile(
                  title: Text(

                    quiz.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                    softWrap: true,
                    quiz.description,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  leading: QuizBadge(topic: topic , quizId: quiz.id),
                ),
              ) ,
            ),
          );
        },
      ).toList(),
    );
  }
}


class QuizBadge extends StatelessWidget {
  final String quizId;
  final Topic topic;
  const QuizBadge({Key? key , required this.quizId , required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // provider helps share widgets across the app with little complexity
    Report report = Provider.of <Report> (context);
    //?? []: This is the null-aware operator. If report.topics[topic.id] is null, the expression on the right side of ?? is returned, which is an empty list []. This ensures that the completed list is never null.
    List completed = report.topics[topic.id] ?? [];
    if (completed.contains(quizId)){
      return const Icon(FontAwesomeIcons.checkDouble , color: Colors.green);
    }else{
      return const Icon(FontAwesomeIcons.solidCircle , color: Colors.grey);
    }
  }
}
