import 'dart:math'; // For random number generation
import 'package:http/http.dart' as http; // HTTP client for API requests
import 'dart:convert'; // JSON encoding/decoding utilities
import '../models/pokemon_card.dart'; // Pokemon card model

class PokemonService {
  static const String baseUrl = 'https://api.pokemontcg.io/v2'; // API endpoint

  // Fetches two random Pokemon cards from the API
  Future<List<PokemonCard>> getRandomCards() async {
    try {
      // Get all cards from the API
      final response = await http.get(Uri.parse('$baseUrl/cards'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final cards = data['data'] as List;

        // Generate two random indices to select cards
        final random = Random();
        final card1Index = random.nextInt(cards.length);
        final card2Index = random.nextInt(cards.length);

        // Return the two randomly selected cards as PokemonCard objects
        return [
          PokemonCard.fromJson(cards[card1Index]),
          PokemonCard.fromJson(cards[card2Index]),
        ];
      }
      throw Exception('Failed to load cards');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
