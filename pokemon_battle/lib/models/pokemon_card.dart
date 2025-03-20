class PokemonCard {
  final String id;
  final String name;
  final String imageUrl;
  final int hp;
  final String type;

  PokemonCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.hp,
    required this.type,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['images']['small'] ?? '',
      hp: int.tryParse(json['hp'] ?? '0') ?? 0,
      type: json['types']?.first ?? 'Unknown',
    );
  }
}
