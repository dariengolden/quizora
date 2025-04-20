import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizora/controllers/controller_question.dart';
import 'package:quizora/utils/constants.dart';

class Options extends StatelessWidget {
  final String text;
  final int index;
  final VoidCallback press;
  const Options({
    super.key,
    required this.text,
    required this.index,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (controller) {
        Color getColor() {
          if (controller.isAnswered) {
            if (index == controller.correctAns) {
              return kGreenColor;
            } else if (index == controller.selectedAns &&
                controller.selectedAns != controller.correctAns) {
              return kRedColor;
            }
          }
          return kGrayColor;
        }

        IconData getIcon() {
          return getColor() == kRedColor ? Icons.close : Icons.done;
        }

        return GestureDetector(
          onTap: press,
          child: Container(
            margin: EdgeInsets.only(top: kDefaultPadding),
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              border: Border.all(color: getColor()),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Text(
                  "${index + 1}.$text",
                  style: TextStyle(color: getColor(), fontSize: 16),
                ),
                Container(
                  decoration: BoxDecoration(
                    color:
                        getColor() == kGrayColor
                            ? Colors.transparent
                            : getColor(),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: getColor()),
                  ),
                  child:
                      getColor() == kGrayColor
                          ? null
                          : Icon(getIcon(), size: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
