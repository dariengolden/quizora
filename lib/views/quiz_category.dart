import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuizCategoryScreen extends StatelessWidget {
  const QuizCategoryScreen({super.key});

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
            itemCount: 50,
            itemBuilder: (context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.question_answer),
                      Text("Quiz Title"),
                      Text("Quiz Subtitle"),
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
