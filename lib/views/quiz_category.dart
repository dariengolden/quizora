import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizora/controllers/controller_question.dart';
import 'package:get/get.dart';
import 'package:quizora/views/quiz_screen.dart';

class QuizCategoryScreen extends StatelessWidget {
  QuizCategoryScreen({super.key});

  final QuestionController _questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/bg.svg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: _questionController.savedCategories.length,
            itemBuilder: (context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      QuizScreen(
                        category: _questionController.savedCategories[index],
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.question_answer),
                      Text(_questionController.savedCategories[index]),
                      Text(_questionController.savedSubtitles[index]),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
