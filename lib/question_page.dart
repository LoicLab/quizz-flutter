import 'package:flutter/material.dart';
import 'package:quizz/welcome_page.dart';

class QuestionPage extends StatefulWidget{
  final String titleAppBar;
  final String titlePage;
  final String question;
  final String image;
  final QuestionPage? nextQuestionPage;
  final int? points;

  const QuestionPage({
    super.key,
    required this.titleAppBar,
    required this.titlePage,
    required this.question,
    required this.image,
    this.nextQuestionPage,
    this.points
  });

  @override
  QuestionPageState createState()=> QuestionPageState();
}

class QuestionPageState extends State<QuestionPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.titleAppBar
        ),
      ),
      body:  Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(widget.titlePage),
          Text(widget.question),
          Image.asset(widget.image),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    showAlert(
                        titleAlert: "Raté",
                        imagePathAlert: 'images/faux.jpg',
                        nextQuestionPage: nextQuestionPage(
                            widget.nextQuestionPage,
                            widget.points
                        ) ,
                        buttonText: "Passé à la question suivante"
                    );
                  },
                  child: const Text('Faux')
              ),
              TextButton(
                  onPressed: () {
                    showAlert(
                        titleAlert: "C'est gagné",
                        imagePathAlert: 'images/vrai.jpg',
                        nextQuestionPage: nextQuestionPage(
                            widget.nextQuestionPage,
                            widget.points
                        ),
                        buttonText: "Passé à la question suivante"
                    );
                  },
                  child: const Text('Vrai')
              )
            ],
          )
        ],
      ),
    );
  }

  /// Popup alert
  Future<void> showAlert({
    required String titleAlert,
    required String imagePathAlert,
    required QuestionPage nextQuestionPage,
    required String buttonText
  }) async{
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(titleAlert),
            content: Image.asset(imagePathAlert),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext ctx){
                          return nextQuestionPage;
                        })
                    );
                  },
                  child: Text(buttonText)
              )
            ],
          );
        });
  }

  ///Question suivante
  nextQuestionPage(QuestionPage? nextQuestionPage, int? points){
      if(nextQuestionPage == null){
         return showDialog(
             barrierDismissible: true,
             context: context,
             builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text("C'est fini"),
                  content: Text("Votre score est de $points"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext ctx){
                                return const WelcomePage();
                              })
                          );
                        },
                        child: const Text("Ok")
                    )
                  ],
                );
             }
         );
      }
      return nextQuestionPage;
  }
}