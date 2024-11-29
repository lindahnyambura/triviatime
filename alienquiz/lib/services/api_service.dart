import 'dart:convert';  // For decoding JSON responses
import 'package:http/http.dart' as http;  // For making HTTP requests
import 'package:logger/logger.dart';  // For logging information

var logger = Logger();  // Initialize logger instance for logging

// Fetches trivia questions from the Open Trivia Database API based on the specified difficulty.

Future<List<dynamic>> fetchTriviaQuestions(String difficulty) async {
  // API URL with the number of questions
  String apiURL = "https://opentdb.com/api.php?amount=5";
  
  logger.i('Fetching data from URL: $apiURL');  // Log the API URL being accessed
  
  try {
    // Send HTTP GET request to the API
    final response = await http.get(Uri.parse(apiURL));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Decode the JSON response
      final data = json.decode(response.body);
      logger.i('Data fetched: ${data['results']}');  // Log the fetched data
      
      // Return the list of questions
      return data['results']; 
    } else {
      // Log error if request failed
      logger.e('Failed to load questions: ${response.statusCode}');
      throw Exception('Failed to load questions');
    }
  } catch (e) {
    // Log any exception that occurs during the request
    logger.e("Error fetching data: $e");
    throw Exception("Error fetching data: $e");
  }
}
