import 'package:flutter/material.dart';
import 'package:quizora/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizora/views/admin/admin_dashboard.dart';
import 'package:quizora/views/quiz_category.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/bg.svg", fit: BoxFit.fitWidth),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    "Welcome to Quizora",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text("Enter your information below"),
                  const Spacer(), // /1/6
                  TextField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      final userName = userNameController.text;
                      if (userName == "Admin" || userName == "admin") {
                        Get.to(AdminDashboard());
                      } else {
                        Get.to(QuizCategoryScreen());
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Let's Start Quiz",
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
