import 'package:flutter/material.dart';
import 'package:quizz/question.dart';
import 'package:quizz/question_page.dart';
import 'package:quizz/datas.dart';

///Page d'accueil
class WelcomePage extends StatelessWidget{
  const WelcomePage({super.key});


  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: const Text(
            'Quizz flutter'
        ),
      ),
      body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                    color: Theme.of(context).colorScheme.onSecondary,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/cover.jpg",
                          fit: BoxFit.cover,
                          height: size.height/3,
                          width: size.width,
                        ),
                        ElevatedButton(
                            onPressed: (){
                              //Récupération de la premiere question
                              Question firstQuestion = Datas().listeQuestions.firstWhere((element) => element.id == 1);
                              //Initialisation de la page de la question 1
                              var questionPage = QuestionPage(
                                  question: firstQuestion, number: 1, points: 0
                              );
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext ctx){
                                    return questionPage;
                                  })
                              );
                            },
                            child: const Text(
                              "Commencer le quizz",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            )
                        )
                      ],
                    )
                )
            )
          ],
        ),
    );
  }
}