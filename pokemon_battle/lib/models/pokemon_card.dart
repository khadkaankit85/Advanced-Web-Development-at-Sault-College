/// Represents a Pokemon card with its essential information
/// This class models data from a Pokemon card API
class PokemonCard {
  /// Unique identifier for the Pokemon card
  final String id;

  /// Name of the Pokemon on the card
  final String name;

  /// URL to the card's image, typically a small thumbnail
  final String imageUrl;

  /// Hit points (HP) value of the Pokemon
  /// Represents the Pokemon's health/durability
  final int hp;

  /// Primary type of the Pokemon (e.g., Fire, Water, Grass)
  /// Only stores the first type if multiple types exist
  final String type;

  /// Constructor requiring all fields
  /// All fields are final and must be provided during initialization
  PokemonCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.hp,
    required this.type,
  });

  /// Factory constructor to create a PokemonCard from JSON data
  /// Handles JSON parsing with null safety and default values
  ///
  /// @param json The JSON map containing Pokemon card data
  /// @return A new PokemonCard instance populated with data from JSON
  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'] ?? '', // Default to empty string if id is null
      name: json['name'] ?? '', // Default to empty string if name is null
      imageUrl: json['images']['small'] ??
          '', // Gets small image URL with empty string fallback
      hp: int.tryParse(json['hp'] ?? '0') ??
          0, // Converts string HP to int with safe parsing
      type: json['types']?.first ??
          'Unknown', // Gets first type from types array with fallback
    );
  }
}
