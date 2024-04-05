import 'package:flutter/material.dart';
import 'package:quizz/question.dart';
import 'package:quizz/datas.dart';

class QuestionPage extends StatefulWidget{
  final String _titleAppBar = "Score: ";
  final String _titlePage = "Question numéro";
  final Question question;
  final int number;
  final int points;

  const QuestionPage({
    super.key,
    required this.question,
    required this.number,
    required this.points
  });

  String getTitlePage(){
    int numberQuestions = Datas().listeQuestions.length;
    return "$_titlePage $number/$numberQuestions";
  }

  @override
  QuestionPageState createState()=> QuestionPageState();
}

class QuestionPageState extends State<QuestionPage>{

  int newPoints=0;

  @override
  Widget build(BuildContext context){
    int? nextQuestionNumber;
    newPoints = widget.points;
    if(widget.number == Datas().listeQuestions.length){
      nextQuestionNumber = null;
    }else{
      nextQuestionNumber = widget.number +1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget._titleAppBar+widget.points.toString()
        ),
      ),
      body:  Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.getTitlePage(),
                    style: const TextStyle(fontSize: 18),
                  )
              )
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 20),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.question.question,
                    style: const TextStyle(fontSize: 15),
                  )
              )
          ),
          Image.asset(widget.question.getImagePath()),
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    answerButton(
                        nextQuestionNumber: nextQuestionNumber,
                        textButton: 'Faux',
                        choice: false
                    ),
                    answerButton(
                        nextQuestionNumber: nextQuestionNumber,
                        textButton: 'Vrai',
                        choice: true
                    )
                  ]
              )
          )

        ],
      ),
    );
  }

  /// Popup alert
  Future<void> showAlert({ required bool choice, required int? nextQuestionNumber}) async{
    String titleAlert;
    String imagePathAlert;
    String explication;
    //Si réponse juste
    if (widget.question.reponse == choice){
      titleAlert = "C'est gagné";
      imagePathAlert = 'images/vrai.jpg';
      explication= '';
      newPoints++;
      //Si fausse
    }else{
      titleAlert = "Raté";
      imagePathAlert = 'images/faux.jpg';
      explication = widget.question.explication;
    }
    QuestionPage questionPage = nextQuestionPage(nextQuestionNumber,newPoints);
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
                          return questionPage;
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
              title: const Text(
                  "C'est fini",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              ),
              content: Text(
                  "Votre score est de $newPoints",
                  style: const TextStyle(
                    fontSize: 18
                  )
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil(
                          ModalRoute.withName('/')
                      );
                    },
                    child: const Text("Ok")
                )
              ],
            );
          }
      );
    }
    return getNextQuestionPage(number: number, points: newPoints);
  }

  ///Récupération de la page de la question suivante
  QuestionPage getNextQuestionPage({required int number, required int points}){
    Question question = Datas().listeQuestions.firstWhere((element) => element.id == number);
    return QuestionPage(
        question: question,
        number: number,
        points: points
    );
  }

  ///Bouton pour la réponse de la question
  ElevatedButton answerButton({required int? nextQuestionNumber, required String textButton, required bool choice}){
    return ElevatedButton(
      onPressed: () {
        showAlert(
            choice: choice,
            nextQuestionNumber: nextQuestionNumber
        );
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          foregroundColor: Colors.white
      ),
      child: Text(textButton),
    );
  }
}