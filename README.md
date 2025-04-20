# Quizora - Interactive Quiz Application

Quizora is a Flutter-based quiz application that allows users to take quizzes on various categories and administrators to manage quiz content. The app features a clean, user-friendly interface and persistent storage using SharedPreferences.

## Features

### User Features
- Take quizzes on different categories
- Interactive question interface with multiple-choice answers
- Real-time answer checking
- Score tracking and results page
- Smooth page transitions between questions

### Admin Features
- Create and manage quiz categories
- Add new questions with multiple-choice options
- Set correct answers for questions
- Persistent storage of questions and categories
- Easy-to-use admin dashboard

## Technical Details

### Architecture
- Built with Flutter and Dart
- Uses GetX for state management
- Implements MVC (Model-View-Controller) pattern
- Uses SharedPreferences for local data persistence

### Key Components
- Question Model: Stores quiz questions, options, and correct answers
- Question Controller: Manages quiz logic and data persistence
- Admin Screen: Interface for managing quiz content
- Quiz Interface: User-facing quiz taking experience

## Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone the repository
```bash
git clone [repository-url]
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the application
```bash
flutter run
```

## Project Structure
```
lib/
├── controllers/
│   └── controller_question.dart
├── models/
│   └── question_model.dart
├── views/
│   ├── admin/
│   │   └── admin_screen.dart
│   └── score_page.dart
└── main.dart
```

## Data Storage
The application uses SharedPreferences to store:
- Quiz questions and answers
- Quiz categories and subtitles
- User progress and scores

## Contributing
Feel free to submit issues and enhancement requests!

## License
[Your chosen license]

## Contact
[Your contact information]
