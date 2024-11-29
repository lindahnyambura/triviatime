import 'package:flutter/material.dart';
import 'quiz_screen.dart'; // Import the quiz screen
import 'settings.dart'; // Import the settings screen

// Home screen widget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/pink.jpg',
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
                  // Welcome Text with Fade-in effect
                  AnimatedOpacity(
                    opacity: 1.0, // Fade-in effect when the screen is loaded
                    duration: Duration(seconds: 2),
                    child: Text(
                      'Welcome to Trivia Time!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: const Color.fromARGB(255, 16, 16, 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Description Text with Fade-in effect
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
                  // Start Quiz Button with Fade-in effect
                  AnimatedOpacity(
                    opacity: 1.0, // Fade-in effect
                    duration: Duration(seconds: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the quiz screen with a slide transition
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
                        backgroundColor: const Color.fromARGB(255, 164, 248, 46), // Button color
                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                      ),
                      child: const Text(
                        'Start Quiz',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: Colors.black, // Text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Settings Button with Fade-in effect
                  AnimatedOpacity(
                    opacity: 1.0, // Fade-in effect
                    duration: Duration(seconds: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to settings screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 196, 87, 251), // Button color
                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                      ),
                      child: const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: Colors.black, // Text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
