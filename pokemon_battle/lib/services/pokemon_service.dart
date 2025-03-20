import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pokemon_card.dart';

class PokemonService {
  static const String baseUrl = 'https://api.pokemontcg.io/v2';

  Future<List<PokemonCard>> getRandomCards() async {
    try {
      // Get all cards
      final response = await http.get(Uri.parse('$baseUrl/cards'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final cards = data['data'] as List;

        // Generate two random indices
        final random = Random();
        final card1Index = random.nextInt(cards.length);
        final card2Index = random.nextInt(cards.length);

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
