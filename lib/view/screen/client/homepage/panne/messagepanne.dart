import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';

class RobotController extends GetxController {
var conversation = "".obs;
// ignore: unused_field
var _repclient = ["oui", "non", "merci"];
var _reprobotelect = [
"Avez-vous remarqué une baisse de la puissance de la batterie récemment ?",
"Est-ce que les feux ou les instruments du tableau de bord fonctionnent normalement ?",
"Avez-vous remarqué des étincelles ou des odeurs étranges lors de la mise en marche de la voiture ?",
"Le moteur de la voiture démarre-t-il normalement ?",
"Avez-vous essayé de démarrer la voiture avec un booster ou un câble de démarrage ?",
"Avez-vous eu des problèmes électriques avec cette voiture auparavant ?",
"Avez-vous vérifié si les fusibles sont en bon état ?",
"Avez-vous essayé de recharger la batterie de la voiture ?",
"Est-ce que la voiture a été récemment exposée à des conditions météorologiques extrêmes, comme une tempête ou une inondation ?",
"Est-ce que la voiture a été impliquée dans un accident récemment ?",
];
var _reprobotmec = [
"Avez-vous remarqué des bruits inhabituels provenant du moteur ou du système de transmission ?",
"Avez-vous constaté une baisse de la puissance du moteur ou des difficultés à accélérer ?",
"Avez-vous remarqué des vibrations ou des secousses inhabituelles lorsque vous conduisez la voiture ?",
"Avez-vous observé une surchauffe du moteur ou une augmentation de la température du liquide de refroidissement ?",
"Avez-vous remarqué une odeur inhabituelle provenant du moteur ou de l'échappement ?",
"Avez-vous remarqué des fuites de liquides provenant du moteur ou de la transmission ?",
"Avez-vous constaté une usure ou une détérioration visible de certaines pièces mécaniques, telles que les courroies, les poulies ou les joints ?",
];

var isElectricalProblem = true.obs;
var conversationEnded = false.obs;

void startConversation() {
conversation.value = "Bonjour, je suis CarBot. Et je suis là pour vous aider.\n";
askQuestion();
}



void askQuestion() {
  if (conversationEnded.value) {
    return;
  }

  var questions;

  if (isElectricalProblem.value) {
    questions = _reprobotelect;
  } else {
    questions = _reprobotmec;
  }

  if (questions.isEmpty) {
    conversation.value += "Désolé, je ne peux pas identifier la panne. Merci d'appeler SOS.\n ";
    conversationEnded.value = true;
    return;
  }

  var question = questions.removeAt(0);
  conversation.value += question + "\n";

  if (questions.isEmpty && isElectricalProblem.value) {
    conversation.value += "Il semble que ce ne soit pas un problème électrique.\n";
    isElectricalProblem.value = false;
    questions = _reprobotmec; 
    question = questions.removeAt(0); 
    conversation.value += question + "\n";
  }
}

void answerQuestion(String answer) {
conversation.value += answer + "\n";
if (conversationEnded.value) {
  return;
}

if (isElectricalProblem.value) {
  if (answer.toLowerCase() == "oui") {
    conversation.value += "Cela suggère qu'il y a probablement un problème électrique.                                   Merci de contacter un electricien.\n";
    conversationEnded.value = true;
    return;
  } else {
    askQuestion();
  }
} else {
  if (answer.toLowerCase() == "oui") {
    conversation.value += "Cela peut indiquer un problème mécanique.                                               Merci de contacter un mécanicien.\n";
    conversationEnded.value = true;
    return;
  }
  askQuestion();
}

if (conversationEnded.value == false) {
  if (answer.toLowerCase() == "merci") {
    conversation.value += "Je t'en prie.\n";
    conversationEnded.value = true;
  }
}
}}

class RobotScreen extends StatelessWidget {
  final RobotController robotController = Get.put(RobotController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:Image.asset("assets/images/robot.png" ,  height: 616, width: 380,),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white.withOpacity(0.5),
        behavior: SnackBarBehavior.floating,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      )
      
      );
    });
    Future.delayed(Duration(seconds: 4), () {
      robotController.startConversation();

});

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Support Technique',
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Comfortaa",
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.white.withAlpha(0),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
      image: AssetImage("assets/images/backgroundmsg.png"),
      fit: BoxFit.cover,
    ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset("assets/images/robot.png" , height: 50,),
                  SizedBox(height: 5,),
                  Text(
                    "Conversation avec CarBot :",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.w900,
                        fontSize: 19),
                        textAlign: TextAlign.center,
                  ),
                ],
              ),
             
              SizedBox(height: 14),
              Expanded(
                child: Obx(() => SingleChildScrollView(
  reverse: true,
  child: Column(
    children: robotController.conversation.value
      .split('\n')
      .map((message) => message.trim())
      .where((message) => message.isNotEmpty)
      .map((message) => Row(
        mainAxisAlignment: message.startsWith('Vous')
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 291),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 4 , horizontal: 3),
            decoration: BoxDecoration(
              borderRadius: message.startsWith('Vous')
                ? BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
                : BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              color: message.startsWith('Vous')
                ? Colors.amber
                : Colors.white,
            ),
            child: Text(
              message.trim(),
              style: TextStyle(
                color: message.startsWith('Vous')
                  ? Colors.white
                  : Colors.black,
                fontFamily: "Comfortaa",
                fontWeight: FontWeight.bold,
                fontSize: 15),
            ),
          ),
        ],
      )).toList(),
  ),
),
),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: !robotController.conversationEnded.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Column(
                      children: [
      Boutton(text: "oui", color: Colors.white , onPressed: () => robotController.answerQuestion("oui"),),
      SizedBox(width: 14),
      Boutton(text: "Non", color: Colors.white , onPressed: () => robotController.answerQuestion("non"),),
      SizedBox(width: 14),
      Boutton(text: "Merci", color: Colors.white , onPressed: () => robotController.answerQuestion("merci"),
)
      ],
      ),
      ],
      ),
      ),
      ],
      ),
      ),
      ),
);
}
}