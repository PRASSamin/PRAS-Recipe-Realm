class FoodRecipe {
  late String foodLabel;
  late String foodImage;
  late String foodUrl;
  late double foodCal;
  late List<String> foodIngredientLines;
  late List foodArea;
  late String foodSource;

  FoodRecipe({
    this.foodLabel = "",
    this.foodImage = "",
    this.foodSource = "",
    this.foodUrl = "",
    this.foodCal = 0.0,
    List<dynamic>? foodIngredientLines,
    this.foodArea = const [],
  }) : foodIngredientLines = (foodIngredientLines ?? []).map((e) => e.toString()).toList();

  factory FoodRecipe.fromMap(Map<String, dynamic> recipe) {
    return FoodRecipe(
      foodLabel: recipe['label'] ?? "",
      foodImage: recipe['image'] ?? "",
      foodUrl: recipe['url'] ?? "",
      foodCal: recipe['calories'] ?? 0.0,
      foodIngredientLines: List<String>.from(recipe['ingredientLines'] ?? []),
      foodArea: recipe['cuisineType'] ?? [],
      foodSource: recipe['source'],
    );
  }
}
