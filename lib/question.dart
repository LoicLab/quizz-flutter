class Question {

  int id;
  String question;
  bool reponse;
  String explication;
  String imageName;

  Question({
    required this.id,
    required this.question,
    required this.reponse,
    required this.explication,
    required this.imageName
  });

  String getImagePath() => 'images/$imageName';
}