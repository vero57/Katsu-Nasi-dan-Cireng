class FoodModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String category;
  final bool isPopular;
  final List<String> ingredients;

  const FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.category,
    this.isPopular = false,
    this.ingredients = const [],
  });

  FoodModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    double? rating,
    String? category,
    bool? isPopular,
    List<String>? ingredients,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      isPopular: isPopular ?? this.isPopular,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'category': category,
      'isPopular': isPopular,
      'ingredients': ingredients,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      category: map['category'] ?? '',
      isPopular: map['isPopular'] ?? false,
      ingredients: List<String>.from(map['ingredients'] ?? const []),
    );
  }
}
