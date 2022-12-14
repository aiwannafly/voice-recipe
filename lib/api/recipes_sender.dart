import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:voice_recipe/model/recipes_info.dart';
import 'package:voice_recipe/api/recipe_fields.dart';

class RecipesSender {
  static const String mediaPostUrl =
      "https://server.voicerecipe.ru/api/v1/media";
  static const String recipePostUrl =
      "https://server.voicerecipe.ru/api/v1/recipe";
  static const String ingPostUrl =
      "https://server.voicerecipe.ru/api/v1/ingredient";
  static const int fail = -1;
  static RecipesSender singleton = RecipesSender._internal();

  RecipesSender._internal();

  factory RecipesSender() {
    return singleton;
  }

  Future<int> sendRecipe(Recipe recipe) async {
    String? recipeJson = await recipeToJson(recipe);
    if (recipeJson == null) {
      return fail;
    }
    debugPrint(recipeJson);
    var response = await http.post(
      Uri.parse(recipePostUrl),
      headers: {
        "Content-Type" : "application/json; charset=UTF-8",
        },
      body: recipeJson
    );
    if (response.statusCode != 200) {
      debugPrint(response.body);
      return fail;
    }
    var idJson = jsonDecode(response.body);
    int? id = idJson["id"];
    if (id == null) {
      return fail;
    }
    return id;
  }

  Future<String?> recipeToJson(Recipe recipe) async {
    int faceId = await sendImage(recipe.faceImageUrl);
    if (fail == faceId) {
      return null;
    }
    List<int>? mediaIds = await loadAllRecipeMedia(recipe.steps);
    if (mediaIds == null) {
      return null;
    }
    List<Map<String, dynamic>> ingsDto = [];
    int count = 0;
    for (Ingredient ing in recipe.ingredients) {
      ingsDto.add({
        ingName: ing.name.toLowerCase(),
        ingUnitName : ing.measureUnit.toLowerCase(),
        ingCount : ing.count
      });
    }
    List<Map<String, dynamic>> stepsDto = [];
    count = 0;
    for (RecipeStep step in recipe.steps) {
      stepsDto.add({
        stepMedia : {
          id : mediaIds[count]
        },
        stepDescription : step.description,
        stepNum : step.id,
        stepWaitTime : step.waitTime > 0 ? step.waitTime: null
      });
      count++;
    }
    Map<String, dynamic> recipeDto = {
      name : recipe.name,
      faceMedia : {
        id : faceId
      },
      cookTimeMins : recipe.cookTimeMins,
      authorId : 1,
      prepTimeMins : recipe.prepTimeMins > 0 ? recipe.prepTimeMins : null,
      kilocalories : recipe.kilocalories > 0 ? recipe.kilocalories : null,
      proteins : recipe.proteins as double?,
      fats : recipe.fats as double?,
      carbohydrates : recipe.carbohydrates as double?,
      ingredientsDistributions : ingsDto,
      steps: stepsDto
    };
    var recipeJson = jsonEncode(recipeDto);
    return recipeJson;
  }

  Future<List<int>?> loadAllRecipeIngredients(List<Ingredient> ings) async {
    if (ings.isEmpty) {
      return null;
    }
    var res = <int>[];
    for (Ingredient ing in ings) {
      int returnCode = await sendIngredient(ing);
      if (returnCode == fail) {
        debugPrint("failed to load ${ing.name}");
        return null;
      }
      res.add(returnCode);
    }
    return res;
  }

  Future<int> sendIngredient(Ingredient ing) async {
      Map<String, dynamic> ingDto = {
        ingName: ing.name.toLowerCase(),
        ingUnitName : ing.measureUnit.toLowerCase(),
        ingCount : ing.count,
        ingredientId : ing.id + 10
      };
      var response = await http.post(
          Uri.parse(recipePostUrl),
          headers: {
            "Content-Type" : "application/json; charset=UTF-8",
          },
          body: jsonEncode(ingDto)
      );
      if (response.statusCode != 200) {
        debugPrint(response.body);
        return fail;
      }
      var idJson = jsonDecode(response.body);
      int? id = idJson["id"];
      if (id == null) {
        return fail;
      }
      return id;
  }

  Future<List<int>?> loadAllRecipeMedia(List<RecipeStep> steps) async {
    if (steps.isEmpty) {
      return null;
    }
    var res = <int>[];
    for (RecipeStep step in steps) {
      int returnCode = await sendImage(step.imgUrl);
      if (returnCode == fail) {
        debugPrint("failed to load ${step.imgUrl}");
        return null;
      }
      res.add(returnCode);
    }
    return res;
  }

  Future<int> sendImage(String imageUrl) async {
    http.Response imageResponse = await http.get(Uri.parse(imageUrl));
    if (imageResponse.statusCode != 200) {
      debugPrint("Could not get image response");
      debugPrint(imageResponse.body);
      return fail;
    }
    var response = await http.post(
      Uri.parse(mediaPostUrl),
      headers: imageResponse.headers,
      body: imageResponse.bodyBytes,
    );
    if (response.statusCode != 200) {
      debugPrint(response.body);
      return fail;
    }
    var idJson = jsonDecode(response.body);
    int? id = idJson["id"];
    if (id == null) {
      return fail;
    }
    return id;
  }
}
