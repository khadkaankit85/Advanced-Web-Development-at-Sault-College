import 'package:flutter/material.dart';
import 'services/pokemon_service.dart';
import 'models/pokemon_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Card Battle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const BattleScreen(),
    );
  }
}

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final PokemonService _pokemonService = PokemonService();
  List<PokemonCard>? _cards;
  String? _winner;
  bool _isLoading = false;

  Future<void> _loadNewCards() async {
    setState(() {
      _isLoading = true;
      _cards = null;
      _winner = null;
    });

    try {
      final cards = await _pokemonService.getRandomCards();
      setState(() {
        _cards = cards;
        _determineWinner();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

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

  @override
  void initState() {
    super.initState();
    _loadNewCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Card Battle'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_cards != null)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCard(_cards![0]),
                    _buildCard(_cards![1]),
                  ],
                ),
              ),
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

  Widget _buildCard(PokemonCard card) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              card.imageUrl,
              height: 200,
              width: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              card.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'HP: ${card.hp}',
              style: const TextStyle(fontSize: 14),
            ),
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
