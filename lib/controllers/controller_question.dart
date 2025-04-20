import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quizora/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:quizora/views/score_page.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // User Interface Code
  late AnimationController _animationController;
  late Animation<double> _animation;
  Animation<double> get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int _correctAns = 0;
  int get correctAns => _correctAns;

  int _selectedAns = 0;
  int get selectedAns => _selectedAns;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  final RxInt _questionNumber = 0.obs;
  RxInt get questionNumber => _questionNumber;

  // Admin Screen
  List<Question> _questions = [];
  List<Question> get questions => _questions;
  final TextEditingController questionTextController = TextEditingController();
  final List<TextEditingController> optionTextController = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final TextEditingController correctAnswerController = TextEditingController();
  final TextEditingController quizCategory = TextEditingController();

  Future<void> saveQuestionToSharedPreferences(Question question) async {
    final prefs = await SharedPreferences.getInstance();
    final questions = await prefs.getStringList("questions") ?? [];

    // Convert the question list to save it into SharedPreferences
    questions.add(jsonEncode(question.toJson()));
    await prefs.getString;
  }

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

  void loadQuestionCategoryFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final categories = prefs.getStringList(_categoryKey) ?? [];
    final subtitles = prefs.getStringList(_subtitleKey) ?? [];

    savedCategories.assignAll(categories);
    savedSubtitles.assignAll(subtitles);
    update();
  }

  void loadQuestionsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final questionJson = prefs.getStringList("questions") ?? [];

    _questions =
        questionJson
            .map((json) => Question.fromJson(jsonDecode(json)))
            .toList();
    update();
  }

  List<Question> getQuestionsByCategory(String category) {
    return _questions
        .where((question) => question.category == category)
        .toList();
  }

  void checkAns(Question question, int selectedText) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedText;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    _animationController.stop();
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() async {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;

      _pageController.nextPage(
        duration: const Duration(microseconds: 250),
        curve: Curves.ease,
      );
    } else {
      Get.to(const ScorePage());
    }
  }

  void updateQuestionNumber(int index) {
    _questionNumber.value = index + 1;
    update();
  }

  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.forward().whenComplete(nextQuestion);
    loadQuestionCategoryFromSharedPreferences();
    loadQuestionsFromSharedPreferences();
    _pageController = PageController();
    update();

    super.onInit();
  }
}
