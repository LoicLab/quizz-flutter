///Question pour le quizz
class Question {

  int id;
  String question;
  bool response;
  String explication;
  String imageName;

  Question({
    required this.id,
    required this.question,
    required this.response,
    required this.explication,
    required this.imageName
  });

  String getImagePath() => 'images/$imageName';
}