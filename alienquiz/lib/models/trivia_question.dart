import 'package:html/parser.dart'; // Import the HTML parser package

// Class representing a trivia question
class TriviaQuestion {
  final String question; // The question text
  final String correctAnswer; // The correct answer to the question
  final List<String> options; // List of answer options
  final String difficulty; // The difficulty level of the question

  // Constructor to initialize the trivia question fields
  TriviaQuestion({
    required this.question,
    required this.correctAnswer,
    required this.options,
    required this.difficulty, // Initialize difficulty
  });

  // Factory constructor to create a TriviaQuestion object from JSON data
  factory TriviaQuestion.fromJson(Map<String, dynamic> json) {
    // Helper function to decode HTML entities in a string
    String decodeHtml(String input) {
      return parse(input).documentElement!.text; // Decode HTML
    }

    // Parse incorrect answers and add the correct answer to the options list
    List<String> options = List<String>.from(json['incorrect_answers']);
    options.add(json['correct_answer']);
    options.shuffle(); // Randomize the order of options

    // Create and return a TriviaQuestion object with decoded values
    return TriviaQuestion(
      question: decodeHtml(json['question']),
      correctAnswer: decodeHtml(json['correct_answer']),
      options: options.map(decodeHtml).toList(),
      difficulty: decodeHtml(json['difficulty']), // Parse difficulty
    );
  }
}
