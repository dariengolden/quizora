import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizora/controllers/controller_question.dart';
import 'package:quizora/views/admin/admin_screen.dart';
// import 'package:flutter/rendering.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final QuestionController questionController = Get.put(QuestionController());
  @override
  void initState() {
    super.initState();
    questionController.loadQuestionCategoryFromSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard"), centerTitle: true),
      body: Obx(() {
        return ListView.builder(
          itemCount: questionController.savedCategories.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Get.to(
                    AdminScreen(
                      quizCategory: questionController.savedCategories[index],
                    ),
                  );
                },
                leading: Icon(Icons.question_answer),
                title: Text(questionController.savedCategories[index]),
                subtitle: Text(questionController.savedSubtitles[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Handle delete action
                  },
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogBox,
        child: const Icon(Icons.add),
      ),
    );
  }

  _showDialogBox() {
    Get.defaultDialog(
      titlePadding: EdgeInsets.only(top: 15),
      contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      title: "Add Quiz",
      content: Column(
        children: [
          TextFormField(
            controller: questionController.categoryTitleController,
            decoration: InputDecoration(hintText: "Enter category name"),
          ),
          TextFormField(
            controller: questionController.categorySubtitleController,
            decoration: InputDecoration(hintText: "Enter category subtitle"),
          ),
        ],
      ),
      textConfirm: "Create",
      textCancel: "Cancel",
      onConfirm: () {
        questionController.savedQuestionsCategoryToSharedPreferences();
        Get.back();
      },
    );
  }
}
