import 'package:flutter/material.dart';
import 'package:quizz/question.dart';
import 'package:quizz/datas.dart';

///Page des questions
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

  ///Formate le titre avec le nombre de question
  String getTitlePage(){
    int numberQuestions = Datas().listeQuestions.length;
    return "$_titlePage $number/$numberQuestions";
  }

  @override
  QuestionPageState createState()=> QuestionPageState();
}

class QuestionPageState extends State<QuestionPage>{

  //Initialisation des nouveaux points
  int newPoints=0;

  @override
  Widget build(BuildContext context){
    //Le numéro de la question suivante
    int? nextQuestionNumber;
    //Mise à jour du nombre de points
    newPoints = widget.points;
    //Si on est sur la dernière question
    if(widget.number == Datas().listeQuestions.length){
      nextQuestionNumber = null;
    }else{
      //Sinon incrémentation
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

  /// Popup alert pour savoir si l'on a répondu juste ou faux et passe à la question suivante
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
    //Récupération de la page de la question suivante
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
                  child: const Text('Passer à la question suivante')
              )
            ],
          );
        });
  }

  ///Page de la question suivante
  nextQuestionPage(int? number, int? points){
    //Si null message d'alerte avec le récapitulatif du score et retourne sur la page d'accueil
    if(number == null){
      return showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext ctx) {
            //Message d'alerte
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
                      //Retourne sur la page d'accueil
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