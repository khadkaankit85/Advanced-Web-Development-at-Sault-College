import 'package:flutter/material.dart';
import 'services/pokemon_service.dart';
import 'models/pokemon_card.dart';

/// Entry point of the application
/// Initializes and runs the Flutter app
void main() {
  runApp(const MyApp());
}

/// Root widget of the application
/// Configures the app theme and initial route
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Card Battle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Enables Material 3 design system
      ),
      home: const BattleScreen(), // Sets the initial screen to BattleScreen
    );
  }
}

/// Main battle screen where users can compare Pokémon cards
/// Implemented as a StatefulWidget to manage the changing state of the battle
class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

/// State management for the BattleScreen
/// Handles loading cards, determining winners, and UI updates
class _BattleScreenState extends State<BattleScreen> {
  // Service to fetch Pokémon card data from API
  final PokemonService _pokemonService = PokemonService();

  // State variables
  List<PokemonCard>? _cards; // Holds the two cards for battle
  String? _winner; // Stores the battle result text
  bool _isLoading = false; // Tracks loading state for UI feedback

  /// Fetches new random cards from the API and determines the winner
  /// Updates state to trigger UI refresh at appropriate points
  Future<void> _loadNewCards() async {
    // Reset state before loading new cards
    setState(() {
      _isLoading = true;
      _cards = null;
      _winner = null;
    });

    try {
      // Fetch random cards from the service
      final cards = await _pokemonService.getRandomCards();

      // Update state with new cards and determine winner
      setState(() {
        _cards = cards;
        _determineWinner();
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors by showing a snackbar message
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  /// Compares the HP of both Pokémon cards to determine the winner
  /// Sets the _winner state variable with appropriate message
  void _determineWinner() {
    if (_cards != null && _cards!.length == 2) {
      if (_cards![0].hp > _cards![1].hp) {
        _winner = '${_cards![0].name} wins!';
      } else if (_cards![1].hp > _cards![0].hp) {
        _winner = '${_cards![1].name} wins!';
      } else {
        _winner = "It's a tie!";
      }
    }
  }

  /// Lifecycle method called when the widget is first inserted into the tree
  /// Used to load the initial set of cards when the screen opens
  @override
  void initState() {
    super.initState();
    _loadNewCards(); // Load cards when the screen first appears
  }

  /// Builds the UI for the battle screen
  /// Shows loading indicator, cards, battle result, and action button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Card Battle'),
        backgroundColor: Colors.red, // Pokémon-themed red color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show loading indicator or cards based on loading state
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_cards != null)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCard(_cards![0]), // Left card
                    _buildCard(_cards![1]), // Right card
                  ],
                ),
              ),

            // Show winner announcement if available
            if (_winner != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _winner!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // Button to start a new battle
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _loadNewCards,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'New Battle',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build a card widget
  /// Displays the card image, name, HP, and type
  Widget _buildCard(PokemonCard card) {
    return Card(
      elevation: 8, // Adds shadow for 3D effect
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Card image from network
            Image.network(
              card.imageUrl,
              height: 200,
              width: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            // Card name
            Text(
              card.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Card HP (the battle determining factor)
            Text(
              'HP: ${card.hp}',
              style: const TextStyle(fontSize: 14),
            ),
            // Card type
            Text(
              'Type: ${card.type}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
