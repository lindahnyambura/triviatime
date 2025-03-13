
# Trivia Time App

Welcome to **Trivia Time**! This Flutter-based application tests your knowledge with random trivia questions across various categories. Dive in, challenge yourself, and see how well you can score!

## Features
- **Random Trivia Questions**: Get a random set of trivia questions each time you play.
- **Difficulty Levels**: Choose your quiz difficulty level from Easy, Medium, or Hard.
- **Track Scores**: Keep track of your score and see the highest scores achieved.
- **Settings**: Customize your quiz experience by setting your preferred difficulty level.


## Getting Started

### Prerequisites
- Ensure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your system.
- You need a suitable IDE like [VSCode](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Installation
1. **Clone the repository:**
    ```sh
    git clone https://github.com/lindahnyambura/triviatime.git
    ```

2. **Navigate to the project directory:**
    ```sh
    cd trivia_time
    ```

3. **Install dependencies:**
    ```sh
    flutter pub get
    ```

4. **Run the app:**
    ```sh
    flutter run
    ```

## Project Structure
- `main.dart`: Entry point of the app.
- `home_screen.dart`: Contains the home screen UI.
- `quiz_screen.dart`: Handles the quiz logic and UI.
- `settings.dart`: Manages the settings page where users can set their quiz difficulty level.
- `models/`: Directory containing model classes.
- `services/`: Directory containing service classes like API calls.

## Usage
### Home Screen
- **Welcome Message**: Displays a welcoming message and a brief description.
- **Start Quiz Button**: Begins the quiz.
- **Settings Button**: Takes you to the settings screen to adjust quiz difficulty.

### Quiz Screen
- **Displays Questions**: Shows trivia questions based on selected difficulty.
- **Options**: Provides multiple-choice answers.
- **Score Tracking**: Shows your current score and allows you to retake the quiz.

### Settings Screen
- **Difficulty Selection**: Allows you to choose the difficulty level of the quiz.

## Dependencies
- `provider`: State management solution.
- `shared_preferences`: For saving user preferences.
- `http`: For making HTTP requests to fetch trivia questions.
- `logger`: For logging information.

## Contributing
1. Fork the repository.
2. Create your feature branch:
    ```sh
    git checkout -b feature/AmazingFeature
    ```
3. Commit your changes:
    ```sh
    git commit -m 'Add some AmazingFeature'
    ```
4. Push to the branch:
    ```sh
    git push origin feature/AmazingFeature
    ```
5. Open a pull request.

## License
Distributed under the MIT License. See `LICENSE` for more information.

## Contact
Your Name - [l.nyambura@alustudent.com](mailto:l.nyambura@alustudent.com)

Project Link: [https://github.com/lindahnyambura/triviatime](https://github.com/lindahnyambura/triviatime)

---
