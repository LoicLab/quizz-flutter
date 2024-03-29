import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget{
  const WelcomePage({super.key});
  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: const Text(
            'Quizz flutter'
          ),
        ),
      body: const SingleChildScrollView(
        child: Column(
            
        ),
      ),
    );
  }
}