import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HangmanGame(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HangmanScreen(),
    );
  }
}

class HangmanGame extends ChangeNotifier {
  final List<String> _wordList = ["FLUTTER", "DEVELOPER", "HANGMAN", "STATE"];
  late String _word;
  Set<String> _guessedLetters = {};
  int _wrongGuesses = 0;
  final int _maxGuesses = 6;

  HangmanGame() {
    _newGame();
  }

  void _newGame() {
    _word = _wordList[Random().nextInt(_wordList.length)];
    _guessedLetters.clear();
    _wrongGuesses = 0;
    notifyListeners();
  }

  String get displayWord => _word
      .split('')
      .map((letter) => _guessedLetters.contains(letter) ? letter : '_')
      .join(' ');

  int get wrongGuesses => _wrongGuesses;
  bool get isGameOver =>
      _wrongGuesses >= _maxGuesses || !displayWord.contains('_');
  bool get isWin => !displayWord.contains('_');

  void guessLetter(String letter) {
    if (!_guessedLetters.contains(letter) && !isGameOver) {
      _guessedLetters.add(letter);
      if (!_word.contains(letter)) {
        _wrongGuesses++;
      }
      notifyListeners();
    }
  }

  void restartGame() {
    _newGame();
  }
}

class HangmanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var game = Provider.of<HangmanGame>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Hangman Game")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Wrong guesses: ${game.wrongGuesses}/6",
              style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          Text(game.displayWord,
              style: TextStyle(fontSize: 30, letterSpacing: 5)),
          SizedBox(height: 20),
          if (!game.isGameOver)
            Wrap(
              spacing: 8,
              children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                  .split('')
                  .map((letter) => ElevatedButton(
                        onPressed: () => game.guessLetter(letter),
                        child: Text(letter),
                      ))
                  .toList(),
            ),
          if (game.isGameOver)
            Column(
              children: [
                Text(game.isWin ? "You Win!" : "Game Over!",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => game.restartGame(),
                  child: Text("Play Again"),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
