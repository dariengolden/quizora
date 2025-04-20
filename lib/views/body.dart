import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizora/controllers/controller_question.dart';
import 'package:quizora/utils/constants.dart';
import 'package:quizora/views/question_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.find();
    PageController pageController = questionController.pageController;
    return Stack(
      fit: StackFit.expand,
      children: [
        SvgPicture.asset(
          "assets/bg.svg",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        SafeArea(
          child: Column(
            children: [
              Obx(
                () => Text.rich(
                  TextSpan(
                    text: "Question ${questionController.questionNumber.value}",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kSecondaryColor,
                    ),
                    children: [
                      TextSpan(
                        text: "/${questionController.questions.length}",
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(color: kSecondaryColor),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(
                color: kSecondaryColor,
                thickness: 1.5,
                indent: 35,
                endIndent: 35,
              ),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: questionController.updateQuestionNumber,
                  itemCount: questionController.questions.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                      question: questionController.questions[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
