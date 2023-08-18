
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/models.dart';


class AnimatedProgressBar extends StatelessWidget {
  final double value; // value from 0-100
  final double height; // fit in different parts on ui i.e topics and quiz screen
  const AnimatedProgressBar({Key? key ,required this.value,  this.height=12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Useful when you dont know size of widget when you build it like width changes dynamically
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        return Container(
          padding: const EdgeInsets.all(10),
          width:  box.maxWidth,
          //Stack to allow us to add widgets on top of each other progress bar has grey bg on default we animate over it with custom color
          child: Stack(
            children: [
              Container(
                height: height,
                // bottom of stack is the grey background (app theme) which is progress bar background
                // Top of stack is last which is AnimatedContainer
                //Progress bar bg
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background, // the default global bg of grey
                  borderRadius: BorderRadius.all(Radius.circular(height)),
                ),
              ),
              AnimatedContainer( // Top of stack which is our Flutters Animated Container Widget
                //It is like a regular container but animates when its properties change like color , height , width
                duration: const Duration(milliseconds: 800) , //How long animation will take when a property changes
                curve: Curves.easeOutCubic,
                height: height,
                width: box.maxWidth * _floor(value),
                decoration: BoxDecoration(
                  color: _colorGen(value),
                  borderRadius: BorderRadius.all(Radius.circular(height),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //Always round NaNs or negative numbers to min value [] is optional
  _floor(double value , [min = 0.0]){
    return value.sign <= min ? min : value;
  }

  _colorGen (double value)
  {
    int rbg = (value * 255).toInt();
    return Colors.deepOrange.withGreen(rbg).withRed(255 - rbg);
  }


}
class TopicProgressBar extends StatelessWidget {
  final Topic topic;
  const TopicProgressBar({Key? key ,required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);

    return Row(
      children: [
        //Show number of completed quizes vs available quizes
        _progressCount(report , topic),
        Expanded(
          child: AnimatedProgressBar(
              value: _calculateProgress(topic , report) , height: 8),
        ),
      ],

    );

  }
}

Widget _progressCount(Report report, Topic topic) {
  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Text(
      '${report.topics[topic.id]?.length ?? 0} / ${topic.quizzes.length}',
      style: const TextStyle(fontSize: 10, color: Colors.grey),
    ),
  );
}

double _calculateProgress(Topic topic, Report report) {
  try {
    int totalQuizzes = topic.quizzes.length;
    int completedQuizzes = report.topics[topic.id].length;
    return completedQuizzes / totalQuizzes;
  } catch (err) {
    return 0.0;
  }
}