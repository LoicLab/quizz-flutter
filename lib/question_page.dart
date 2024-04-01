import 'package:flutter/material.dart';
import 'package:quizz/question.dart';
import 'package:quizz/welcome_page.dart';
import 'package:quizz/datas.dart';

class QuestionPage extends StatefulWidget{
  final String _titleAppBar = "Score";
  final String _titlePage = "Question numéro";
  final Question question;
  final int? points;
  final int number;

  const QuestionPage({
    super.key,
    required this.question,
    this.points,
    required this.number
  });

  String getTitleAppBar(){
     return "$_titleAppBar $points";
  }

  String getTitlePage(){
    int numberQuestions = Datas().listeQuestions.length;
    return "$_titlePage $number/$numberQuestions";
  }

  @override
  QuestionPageState createState()=> QuestionPageState();
}

class QuestionPageState extends State<QuestionPage>{

  @override
  Widget build(BuildContext context){
    int? nextQuestionNumber;
    if(widget.number == Datas().listeQuestions.length){
      nextQuestionNumber = null;
    }else{
      nextQuestionNumber = widget.number +1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.getTitleAppBar()
        ),
      ),
      body:  Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(widget.getTitlePage()),
          Text(widget.question.question),
          Image.asset(widget.question.getImagePath()),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    showAlert(
                        nextQuestionPage: nextQuestionPage(
                            nextQuestionNumber,
                            widget.points
                        ),
                        choice: false
                    );
                  },
                  child: const Text('Faux')
              ),
              TextButton(
                  onPressed: () {
                    showAlert(
                        nextQuestionPage: nextQuestionPage(
                            nextQuestionNumber,
                            widget.points
                        ),
                        choice: true
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
  Future<void> showAlert({required QuestionPage nextQuestionPage, required bool choice}) async{
    String titleAlert;
    String imagePathAlert;
    String explication;
    if (widget.question.reponse == choice){
      titleAlert = "C'est gagné";
      imagePathAlert = 'images/vrai.jpg';
      explication= '';
    }else{
      titleAlert = "Raté";
      imagePathAlert = 'images/faux.jpg';
      explication = widget.question.explication;
    }
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(titleAlert),
            content: Image.asset(imagePathAlert),
            actions: [
              Text(explication),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext ctx){
                          return nextQuestionPage;
                        })
                    );
                  },
                  child: const Text('Passé à la question suivante')
              )
            ],
          );
        });
  }

  ///Question suivante
  nextQuestionPage(int? number, int? points){
      if(number == null){
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
      return getNextQuestionPage(number: number);
  }

  ///Récupération de la page de la question suivante
  QuestionPage getNextQuestionPage({required int number}){
    Question question = Datas().listeQuestions.firstWhere((element) => element.id == number);
    return QuestionPage(
        question: question,
        number: number
    );
  }
}