import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizora/controllers/controller_question.dart';
import 'package:quizora/question_model.dart';
import 'package:quizora/utils/constants.dart';
import 'package:quizora/views/option.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.questions,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(color: kBlackColor),
          ),

          const SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Options(
              text: question.options[index],
              index: index,
              press: () => questionController.checkAns(question, index),
            ),
          ),
        ],
      ),
    );
  }
}
