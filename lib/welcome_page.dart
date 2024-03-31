import 'package:flutter/material.dart';
import 'package:quizz/question_page.dart';

class WelcomePage extends StatefulWidget{
  const WelcomePage({super.key});
  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage>{
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
      body: SingleChildScrollView(
        child: Column(
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
                        height: 250,
                        width: size.width,
                      ),
                      TextButton(
                          onPressed: (){
                            const questionPage = QuestionPage(
                              titleAppBar: "test",
                              titlePage: 'Question numéro',
                              question: 'La devis',
                              image: 'images/belgique.jpg',
                              nextQuestionPage: QuestionPage(
                                  titleAppBar: "Score",
                                  titlePage: "Question numéro 2",
                                  question: "La lune va finir par tomber",
                                  image: "images/lune.jpg",
                                  nextQuestionPage: null
                              ),
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
      ),
    );
  }
}