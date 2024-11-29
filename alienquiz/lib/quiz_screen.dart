import 'package:flutter/material.dart';
import 'services/api_service.dart'; // Import the API service
import 'models/trivia_question.dart'; // Import the TriviaQuestion model
import 'leaderboard_screen.dart'; // Import the leaderboard screen
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia Time'),
        backgroundColor: const Color.fromARGB(255, 143, 255, 68),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/alien.jpg', 
              fit: BoxFit.cover,
            ),
          ),
          // Main Content (Column of widgets)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: 1.0, // Fade-in effect when the screen is loaded
                    duration: Duration(seconds: 2),
                    child: Text(
                      'Welcome to Trivia Time!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: const Color.fromARGB(255, 5, 5, 5),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0, // Fade-in effect
                    duration: Duration(seconds: 3),
                    child: Text(
                      'Test your knowledge with random trivia questions from various categories.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Start Quiz Button
                  AnimatedOpacity(
                    opacity: 1.0, // Fade-in effect
                    duration: Duration(seconds: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => QuizScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(position: offsetAnimation, child: child);
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 149, 255, 68), // Button color
                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: Text('Start Quiz'),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Settings Button
                  AnimatedOpacity(
                    opacity: 1.0, // Fade-in effect
                    duration: Duration(seconds: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to settings screen or add functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Button color
                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: Text('Settings'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  late Future<List<TriviaQuestion>> _questions;
  String _difficulty = 'Easy'; // Default difficulty

  @override
  void initState() {
    super.initState();
    _loadDifficulty().then((_) {
      setState(() {
        _questions = loadQuestions();
      });
    });
  }

  // Load difficulty from SharedPreferences
  Future<void> _loadDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _difficulty = prefs.getString('difficulty') ?? 'Easy';
      logger.i('Loaded difficulty: $_difficulty');
    });
  }

  // Fetch trivia questions based on difficulty
  Future<List<TriviaQuestion>> loadQuestions() async {
  try {
    final data = await fetchTriviaQuestions(_difficulty);
    logger.i('Fetched questions: $data');
    return data.map<TriviaQuestion>((json) => TriviaQuestion.fromJson(json)).toList();
  } catch (e) {
    logger.e('Error fetching questions: $e');
    throw e;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trivia Time',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 164, 248, 46),

      ),
      body: FutureBuilder<List<TriviaQuestion>>(
        future: _questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final questions = snapshot.data!;
            return QuestionList(questions: questions);
          } else {
            return const Center(
              child: Text('No questions available'),
            );
          }
        },
      ),
    );
  }
}


class QuestionList extends StatefulWidget {
  final List<TriviaQuestion> questions;

  const QuestionList({required this.questions});

  @override
  QuestionListState createState() => QuestionListState();
}

class QuestionListState extends State<QuestionList> {
  Map<int, String?> selectedAnswers = {}; // Map to store user's answers
  Map<int, bool> isAnswered = {}; // Tracks if each question has been answered
  bool isQuizSubmitted = false; // Tracks if the quiz has been submitted

  // Function to calculate score
  int calculateScore() {
    int score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedAnswers[i] == widget.questions[i].correctAnswer) {
        score++;
      }
    }
    return score;
  }

  // Function to save the score to SharedPreferences
  Future<void> _saveHighestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    int highestScore = prefs.getInt('highest_score') ?? 0;
    if (score > highestScore) {
      await prefs.setInt('highest_score', score); // Save new highest score
    }
  }

  // Function to reset the quiz
  void resetQuiz() {
    setState(() {
      selectedAnswers.clear();
      isAnswered.clear();
      isQuizSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.questions.length,
            itemBuilder: (context, index) {
              final question = widget.questions[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display Question
                      Text(
                        'Q${index + 1}: ${question.question}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Display Difficulty
                      Text(
                        'Difficulty: ${question.difficulty}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: question.difficulty == 'Easy'
                              ? Colors.green
                              : question.difficulty == 'Medium'
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Display Options
                      ...question.options.map((option) {
                        return GestureDetector(
                          onTap: isAnswered[index] == true || isQuizSubmitted
                              ? null // Disable if already answered or submitted
                              : () {
                                  setState(() {
                                    selectedAnswers[index] = option;
                                    isAnswered[index] = true; // Mark question as answered
                                  });
                                },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selectedAnswers[index] == option
                                  ? Colors.black12.withOpacity(0.6)
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                ),
                            ),
                          ),
                        );
                      }).toList(),

                      // Feedback for Answer
                      if (isAnswered[index] == true)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            selectedAnswers[index] == question.correctAnswer
                                ? 'Correct!'
                                : 'Incorrect. The correct answer is: ${question.correctAnswer}',
                            style: TextStyle(
                              color: selectedAnswers[index] == question.correctAnswer
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Submit Button
        ElevatedButton(
          onPressed: isQuizSubmitted
              ? null // Disable if the quiz is already submitted
              : () async {
                  final score = calculateScore();
                  // Save the score after quiz submission
                  await _saveHighestScore(score);

                  // Mark quiz as submitted
                  setState(() {
                    isQuizSubmitted = true;
                  });

                  // Navigate to the leaderboard/progress screen
                  if (mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LeaderboardScreen(
                          userScore: score,
                          totalQuestions: widget.questions.length,
                        ),
                      ),
                    );
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: isQuizSubmitted ? Colors.grey : const Color.fromARGB(255, 164, 248, 46),
          ),
          child: const Text(
            'Submit Quiz',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black
            ),
            ),
        ),

        // Reset Button (only visible if the quiz is submitted)
        if (isQuizSubmitted)
          ElevatedButton(
            onPressed: resetQuiz,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text(
              'Retake Quiz',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black
              ),
          ),
        ),
      ],
    );
  }
}
