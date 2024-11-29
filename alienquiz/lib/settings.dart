import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // To save settings persistently

// Settings screen widget
class SettingsScreen extends StatefulWidget {
  @override
  SettingsScreenState createState() => SettingsScreenState();
}

// State of the SettingsScreen
class SettingsScreenState extends State<SettingsScreen> {
  String _selectedDifficulty = 'Easy'; // Default difficulty level
  List<String> _difficultyLevels = ['Easy', 'Medium', 'Hard']; // List of difficulty levels

  // Function to load saved difficulty from SharedPreferences
  Future<void> _loadDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedDifficulty = prefs.getString('difficulty') ?? 'Easy'; // Load the saved difficulty
    });
  }

  // Function to save selected difficulty to SharedPreferences
  Future<void> _saveDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('difficulty', _selectedDifficulty); // Save the selected difficulty
  }

  @override
  void initState() {
    super.initState();
    _loadDifficulty(); // Load the saved difficulty when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 146, 186), // App bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Quiz Difficulty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Difficulty selection with a dropdown menu
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the dropdown menu
                borderRadius: BorderRadius.circular(8), // Rounded corners
                border: Border.all(color: const Color.fromARGB(255, 248, 146, 186)), // Border color
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedDifficulty,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDifficulty = newValue!;
                    });
                    _saveDifficulty(); // Save the new difficulty
                  },
                  items: _difficultyLevels.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
            const SizedBox(height: 40),

            // Save and Return Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the settings screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 196, 87, 251), // Button background color
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Button border radius
                  ),
                ),
                child: const Text(
                  'Save and Return',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
