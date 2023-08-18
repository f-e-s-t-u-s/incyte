import 'package:flutter/material.dart';

import '../services/models.dart';
import '../shared/progress_bar.dart';
import 'drawer.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({Key? key , required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TopicScreen(topic : topic),
              )
              ,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: Image.network(topic.img, height: 100,),/* Image.asset(
                    'assets/covers/${topic.img }',
                    fit: BoxFit.contain,
                  ),*/
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10 , right: 10) ,
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      height:  1.5,
                      fontWeight:  FontWeight.bold,
                    ),
                    overflow:  TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              Flexible(
                child: TopicProgressBar(topic: topic),
              )
            ],
          ) ,
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {

  final Topic topic;


  const TopicScreen({Key? key , required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: topic.img,
            // child: Image.asset('assets/covers/${topic.img}' , height: 100,) ,
            child:Image.network(topic.img , height: 100,) ,

          ),
          Text(
            topic.title,
            style: const TextStyle(
                height: 2, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          QuizList(topic:topic)
        ],
      ),

    );
  }
}

