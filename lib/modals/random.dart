import 'dart:convert';
import 'package:http/http.dart';

class Meal {
  late String? idMeal;
  late String? strMeal;
  late String? strCategory;
  late String? strArea;
  late String? strInstructions;
  late String? strMealThumb;
  late String? strYoutube;
  late String? strIngredient1;
  late String? strIngredient2;
  late String? strIngredient3;
  late String? strIngredient4;
  late String? strIngredient5;
  late String? strIngredient6;
  late String? strIngredient7;
  late String? strIngredient8;
  late String? strIngredient9;
  late String? strIngredient10;
  late String? strIngredient11;
  late String? strIngredient12;
  late String? strIngredient13;
  late String? strIngredient14;
  late String? strIngredient15;
  late String? strIngredient16;
  late String? strIngredient17;
  late String? strIngredient18;
  late String? strIngredient19;
  late String? strIngredient20;
  late String? strMeasure1;
  late String? strMeasure2;
  late String? strMeasure3;
  late String? strMeasure4;
  late String? strMeasure5;
  late String? strMeasure6;
  late String? strMeasure7;
  late String? strMeasure8;
  late String? strMeasure9;
  late String? strMeasure10;
  late String? strMeasure11;
  late String? strMeasure12;
  late String? strMeasure13;
  late String? strMeasure14;
  late String? strMeasure15;
  late String? strMeasure16;
  late String? strMeasure17;
  late String? strMeasure18;
  late String? strMeasure19;
  late String? strMeasure20;
  late String? strSource;

  Meal({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strYoutube,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strIngredient16,
    this.strIngredient17,
    this.strIngredient18,
    this.strIngredient19,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strMeasure16,
    this.strMeasure17,
    this.strMeasure18,
    this.strMeasure19,
    this.strMeasure20,
    this.strSource,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strYoutube: json['strYoutube'],
      strIngredient1: json['strIngredient1'],
      strIngredient2: json['strIngredient2'],
      strIngredient3: json['strIngredient3'],
      strIngredient4: json['strIngredient4'],
      strIngredient5: json['strIngredient5'],
      strIngredient6: json['strIngredient6'],
      strIngredient7: json['strIngredient7'],
      strIngredient8: json['strIngredient8'],
      strIngredient9: json['strIngredient9'],
      strIngredient10: json['strIngredient10'],
      strIngredient11: json['strIngredient11'],
      strIngredient12: json['strIngredient12'],
      strIngredient13: json['strIngredient13'],
      strIngredient14: json['strIngredient14'],
      strIngredient15: json['strIngredient15'],
      strIngredient16: json['strIngredient16'],
      strIngredient17: json['strIngredient17'],
      strIngredient18: json['strIngredient18'],
      strIngredient19: json['strIngredient19'],
      strIngredient20: json['strIngredient20'],
      strMeasure1: json['strMeasure1'],
      strMeasure2: json['strMeasure2'],
      strMeasure3: json['strMeasure3'],
      strMeasure4: json['strMeasure4'],
      strMeasure5: json['strMeasure5'],
      strMeasure6: json['strMeasure6'],
      strMeasure7: json['strMeasure7'],
      strMeasure8: json['strMeasure8'],
      strMeasure9: json['strMeasure9'],
      strMeasure10: json['strMeasure10'],
      strMeasure11: json['strMeasure11'],
      strMeasure12: json['strMeasure12'],
      strMeasure13: json['strMeasure13'],
      strMeasure14: json['strMeasure14'],
      strMeasure15: json['strMeasure15'],
      strMeasure16: json['strMeasure16'],
      strMeasure17: json['strMeasure17'],
      strMeasure18: json['strMeasure18'],
      strMeasure19: json['strMeasure19'],
      strMeasure20: json['strMeasure20'],
      strSource: json['strSource'],
    );
  }

  static fromMap(jsonDecode) {}

  toMap() {}

  toJson() {}

  static fetchMealById(String id) {}
}

class RecipeService {
  static String url = "https://www.themealdb.com/api/json/v1/1/random.php";

  static Future<List<Meal>> fetchRandomRecipes(int count) async {
    List<Meal> recipes = [];
    for (int i = 0; i < count; i++) {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> mealsData = json.decode(response.body)['meals'];
        for (var mealData in mealsData) {
          recipes.add(Meal.fromJson(mealData));
        }
      } else {
        throw Exception('Failed to load random recipes');
      }
    }
    return recipes;
  }

  static fetchRecipeById(String id) {}
}
