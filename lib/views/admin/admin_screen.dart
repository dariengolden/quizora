import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizora/controllers/controller_question.dart';
import 'package:quizora/question_model.dart';

class AdminScreen extends StatelessWidget {
  final String quizCategory;
  AdminScreen({super.key, required this.quizCategory});
  final QuestionController questionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add questions to $quizCategory")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: questionController.questionTextController,
                decoration: const InputDecoration(labelText: "Question"),
              ),
              for (var i = 0; i < 4; i++)
                TextFormField(
                  controller: questionController.optionTextController[i],
                  decoration: InputDecoration(labelText: "Option ${i + 1}"),
                ),
              TextFormField(
                controller: questionController.correctAnswerController,
                decoration: const InputDecoration(
                  labelText: "Correct Answers (0-3)",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle save action
                  if (questionController
                      .questionTextController
                      .text
                      .isNotEmpty) {
                    Get.snackbar("Required", "Please fill in all fields");
                  } else if (questionController
                      .optionTextController[0]
                      .text
                      .isNotEmpty) {
                    Get.snackbar("Required", "Please fill in all fields");
                  } else if (questionController
                      .optionTextController[1]
                      .text
                      .isNotEmpty) {
                    Get.snackbar("Required", "Please fill in all fields");
                  } else if (questionController
                      .optionTextController[2]
                      .text
                      .isNotEmpty) {
                    Get.snackbar("Required", "Please fill in all fields");
                  } else if (questionController
                      .optionTextController[3]
                      .text
                      .isNotEmpty) {
                    Get.snackbar("Required", "Please fill in all fields");
                  } else {
                    addQuestion();
                    Get.back();
                  }
                },
                child: const Text("Add Question"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addQuestion() async {
    // collecting questions from the text controllers
    final String questionText = questionController.questionTextController.text;
    final List<String> options =
        questionController.optionTextController
            .map((controller) => controller.text)
            .toList();
    final int correctAnswer =
        int.tryParse(questionController.correctAnswerController.text) ?? 1;

    // Creating a new question instance
    final Question newQuestion = Question(
      id: DateTime.now().microsecondsSinceEpoch, // Very unique ID
      category: quizCategory,
      questions: questionText,
      options: options,
      answer: correctAnswer,
    );

    // Save question to SharedPreferences
    await questionController.saveQuestionToSharedPreferences(newQuestion);
  }
}
