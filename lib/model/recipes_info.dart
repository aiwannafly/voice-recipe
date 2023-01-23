import 'dart:collection';

class Recipe {
  int id;
  String name;
  String faceImageUrl;
  int cookTimeMins;
  int prepTimeMins;
  double kilocalories;
  int? proteins;
  int? fats;
  int? carbohydrates;
  List<Ingredient> ingredients;
  List<RecipeStep> steps;

  Recipe({required this.name, required this.faceImageUrl, required this.id,
  required this.cookTimeMins, required this.prepTimeMins, required this.kilocalories,
    required this.ingredients, required this.steps
  });
}

class Ingredient {
  int id;
  String name;
  double count;
  String measureUnit;

  Ingredient({required this.id, required this.name, required this.count, required this.measureUnit});
}

class RecipeStep {
  int id;
  String imgUrl;
  String description;
  int waitTime;

  bool hasImage;

  RecipeStep({required this.id, required this.imgUrl, required this.description, this.waitTime = 0, this.hasImage = true});
}

int recipesCounter = 35;

final ratesMap = HashMap<int, int>();

final List<double> rates = [
  4.1, 4.7, 4.1, 4.2, 4.4, 4.9, 4.3,
];
