import 'package:flutter/material.dart';
import 'package:voice_recipe/api/recipes_getter.dart';
import 'package:voice_recipe/screens/collections/collection_screen.dart';
import 'package:voice_recipe/screens/not_found_screen.dart';

import '../../model/recipes_info.dart';
import '../loading_screen.dart';

class FutureCollectionScreen extends StatelessWidget {
  const FutureCollectionScreen({super.key, required this.name});

  static const route = "/collections/";

  final String name;

  @override
  Widget build(BuildContext context) {
    if (RecipesGetter().collectionsCache.containsKey(name)) {
      return CollectionScreen(recipes: RecipesGetter().collectionsCache[name]!,
      setName: "Talky Chef",);
    }
    return FutureBuilder(
      future: RecipesGetter().getCollection(name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen(postfix: " подборку",);
          }
          List<Recipe>? collection = snapshot.data;
          if (collection == null) {
            return const NotFoundScreen(message: "Подборка не найдена",);
          }
          return CollectionScreen(recipes: collection, setName: "Talky Chef");
        });
  }
}
