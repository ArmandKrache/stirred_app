import 'package:stirred_app/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

final currentProfileProvider = StateProvider<Profile?>((ref) => null);

final allPossibleCategoriesProvider = StateProvider<Categories?>((ref) => null);

final allPossibleDifficultiesProvider = StateProvider<List<String>>((ref) => []);

final allPossibleUnitsProvider = StateProvider<List<String>>((ref) => []);

String getDifficultyTitle(String key, WidgetRef ref) {
  final difficulties = ref.read(allPossibleDifficultiesProvider);
  if (difficulties.contains(key)) {
    switch (key) {
      case "beginner": return "Beginner";
      case "intermediate": return "Intermediate";
      case "advanced": return "Advanced";
      case "expert": return "Expert";
      case "master": return "Master";
      default: return "Unknown";
    }
  }
  return "Unknown";
}

Color getDifficultyColor(String key, WidgetRef ref) {
  final difficulties = ref.read(allPossibleDifficultiesProvider);
  if (difficulties.contains(key)) {
    switch (key) {
      case "beginner": return commonColor;
      case "intermediate": return unusualColor;
      case "advanced": return rareColor;
      case "expert": return epicColor;
      case "master": return legendaryColor;
      default: return commonColor;
    }
  }
  return commonColor;
}

String getUnitTitle(String key, WidgetRef ref) {
  final units = ref.read(allPossibleUnitsProvider);
  if (units.contains(key)) {
    switch (key) {
      case "cup": return "Cup";
      case "teaspoon": return "Teaspoon";
      case "tablespoon": return "TableSpoon";
      case "gram": return "Gram";
      case "milliliter": return "Milliliter";
      case "slice": return "Slice";
      case "pinch": return "Pinch";
      default: return "Unknown";
    }
  }
  return "Unknown";
}