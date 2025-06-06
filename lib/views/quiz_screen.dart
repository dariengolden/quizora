import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizora/controllers/controller_question.dart';
import 'package:quizora/views/body.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuestionController questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [TextButton(onPressed: () {}, child: const Text('Skip'))],
      ),
      body: Body(),
    );
  }
}
