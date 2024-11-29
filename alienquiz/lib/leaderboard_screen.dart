import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // import SharedPreferences
import 'quiz_screen.dart'; // import the quiz screen (for navigation)

// Leaderboard screen widget
class LeaderboardScreen extends StatefulWidget {
  final int userScore; // User's score
  final int totalQuestions; // Total number of questions

  const LeaderboardScreen({
    super.key,
    required this.userScore,
    required this.totalQuestions,
  });

  @override
  LeaderboardScreenState createState() => LeaderboardScreenState();
}

// Leaderboard screen state
class LeaderboardScreenState extends State<LeaderboardScreen> {
  int highestScore = 0; // Variable to store the highest score

  // Function to load the highest score from SharedPreferences
  Future<void> _loadHighestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      highestScore = prefs.getInt('highest_score') ?? 0; // Load highest score
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHighestScore(); // Load highest score when screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/pink.jpg', // Background image
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // User Score Display
                  Card(
                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8), // Card background color with opacity
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Your Score',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            '${widget.userScore} / ${widget.totalQuestions}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Highest Score Display
                  Card(
                    color: Colors.white.withOpacity(0.8), // Card background color with opacity
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Highest Score',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            '$highestScore / ${widget.totalQuestions}',
                            style: TextStyle(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 196, 87, 251),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Navigation Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(), // Navigate to new quiz screen
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 164, 248, 46), // Button color
                        ),
                        child: const Text(
                          'Retake Quiz',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst); // Return to Home
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 196, 87, 251), // Button color
                        ),
                        child: const Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
