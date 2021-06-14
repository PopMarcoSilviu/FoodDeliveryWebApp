
class CompositeMenuItem {
  final String title;
  final double rating;
  final double calories;
  final double protein;
  final double fat;
  final double sodium;
  final double price;

  const CompositeMenuItem({required this.title,
    required this.rating,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.sodium,
    required this.price});

  factory CompositeMenuItem.fromJson(Map<String, dynamic> json)
  {
    return CompositeMenuItem(title: json['title'],
        rating: json['rating'],
        calories: json['calories'],
        protein: json['protein'],
        fat: json['fat'],
        sodium: json['sodium'],
        price: json['price']);
  }
}
