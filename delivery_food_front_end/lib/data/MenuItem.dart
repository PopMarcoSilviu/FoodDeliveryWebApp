
class MenuItem {
   String title;
   double rating;
   double calories;
   double protein;
   double fat;
   double sodium;
   double price;

   MenuItem({required this.title,
    required this.rating,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.sodium,
    required this.price});

  factory MenuItem.fromJson(Map<String, dynamic> json)
  {
    return MenuItem(title: json['title'],
        rating: json['rating'],
        calories: json['calories'],
        protein: json['protein'],
        fat: json['fat'],
        sodium: json['sodium'],
        price: json['price']);
  }

  Map<String,dynamic> toJson()=>
      {
        'title': this.title,
        'rating': this.rating,
        'calories': this.calories,
        'protein': this.protein,
        'fat': this.fat,
        'sodium': this.sodium,
        'price': this.price,

      };
}
