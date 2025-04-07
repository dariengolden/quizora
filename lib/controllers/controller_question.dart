import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quizora/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionController {
  final List<Question> _questions = [];
  List<Question> get questions => _questions;

  // Admin Dashboard
  final String _categoryKey = "category_title";
  final String _subtitleKey = "subtitle_title";
  TextEditingController categoryTitleController = TextEditingController();
  TextEditingController categorySubtitleController = TextEditingController();

  RxList<String> savedCategories = <String>[].obs;
  RxList<String> savedSubtitles = <String>[].obs;

  void savedQuestionsCategoryToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (categoryTitleController.text.isNotEmpty &&
        categorySubtitleController.text.isNotEmpty) {
      savedCategories.add(categoryTitleController.text);
      savedSubtitles.add(categorySubtitleController.text);

      await prefs.setStringList(_categoryKey, savedCategories);
      await prefs.setStringList(_subtitleKey, savedSubtitles);

      categorySubtitleController.clear();
      categoryTitleController.clear();

      Get.snackbar("Saved", "Category created successfully");
    } else {
      Get.snackbar("Error", "Please fill in all fields");
    }
  }
}
