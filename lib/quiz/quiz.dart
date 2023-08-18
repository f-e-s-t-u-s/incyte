import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incyte/quiz/quiz_state.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/firestore.dart';
import '../services/models.dart';
import '../shared/loading.dart';
import '../shared/progress_bar.dart';

class QuizScreen extends StatelessWidget {
  final String quizId;
  const QuizScreen({Key? key , required this.quizId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => QuizState(),
        child: FutureBuilder<Quiz>(
          future: FirestoreService().getQuiz(quizId),
          builder: (context, snapshot) {
            var state = Provider.of <QuizState> (context);

            if(!snapshot.hasData || snapshot.hasError){
              return const Loader();
            }else{
              var quiz = snapshot.data!;
              return Scaffold(
                appBar: AppBar(
                  title: AnimatedProgressBar(
                    value: state.progress,
                  ),
                  leading: IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark),
                    onPressed: () {
                      //allow user leave quiz if doesn't want to finish
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: state.controller,
                  onPageChanged: (int idx) => state.progress = (idx / (quiz.questions.length + 1)),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0)
                    {
                      return StartPage(quiz: quiz);
                    } else if (index == quiz.questions.length + 1)
                    {
                      return CongratsPage(quiz: quiz);
                    }else{
                      return QuestionPage(question: quiz.questions[index- 1 ]);
                    }
                  },
                ),
              );

            }
          },
        )
    ) ;
  }
}





class StartPage extends StatelessWidget {

  final Quiz quiz;

  const StartPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: Theme
              .of(context)
              .textTheme
              .headlineMedium),
          const Divider(),
          Expanded(child: Text(quiz.description)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [

              if(quiz.video.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: () async {
                    var url = quiz.video;

                    if(await canLaunchUrl(Uri.parse(url))) {

                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.inAppWebView,
                      );
                    }
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Watch Video'),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.redAccent),
                  ),
                ),

              // const Spacer(), !!deadly
              ElevatedButton.icon(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Colors.green,
                    )
                ),
                onPressed: () {
                  state.nextPage();
                },
                icon: const Icon(Icons.poll),
                label: const Text('Start Quiz'),
              )
            ],
          ),

        ],
      ),
    );
  }

}



class CongratsPage extends StatelessWidget {

  final Quiz quiz;
  CongratsPage({super.key, required this.quiz});

  final List<String> imageList = [
    'assets/congrats/0.gif',
    'assets/congrats/1.gif',
    'assets/congrats/2.gif',
    'assets/congrats/3.gif',
    'assets/congrats/4.gif',
    'assets/congrats/5.gif',
    'assets/congrats/6.gif',
    'assets/congrats/7.gif',
    'assets/congrats/8.gif',
    'assets/congrats/9.gif',
    'assets/congrats/10.gif',
    'assets/congrats/11.gif',
    'assets/congrats/12.gif',
    'assets/congrats/13.gif',
    'assets/congrats/14.gif',
  ];

  @override
  Widget build(BuildContext context) {

    var randomAssetIndex = Random().nextInt(16);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats! You completed the ${quiz.title} quiz',
            textAlign: TextAlign.center,
          ),
          const Divider(),
          Image.asset('assets/congrats/$randomAssetIndex.gif'),
          const Divider(),
          ElevatedButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            icon: const Icon(FontAwesomeIcons.check),
            label: const Text(' Mark Complete!'),
            onPressed: () {
              FirestoreService().updateUserReport(quiz);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/topics',
                    (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((opt) {
              return Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.black26,
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                            state.selected == opt
                                ? FontAwesomeIcons.circleCheck
                                : FontAwesomeIcons.circle,
                            size: 30),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  /// Bottom sheet shown when Question is answered
  _bottomSheet(BuildContext context, Option opt, QuizState state) {
    bool correct = opt.correct;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(correct ? 'Good Job!' : 'Wrong'),
              Text(
                opt.detail,
                style: const TextStyle(fontSize: 18, color: Colors.white54),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: correct ? Colors.green : Colors.red),
                child: Text(
                  correct ? 'Onward!' : 'Try Again',
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

