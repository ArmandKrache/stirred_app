import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';

final globalDataInitializationProvider = FutureProvider<void>((ref) async {
  final apiRepository = ref.read(apiRepositoryProvider);
  final response = await apiRepository.getAllChoices();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (response is DataSuccess) {
    final data = response.data!;
    ref.read(allPossibleCategoriesProvider.notifier).state = Categories(
      seasons: data.seasons,
      diets: data.diets,
      strengths: data.strengths,
      eras: data.eras,
      colors: data.colors,
      origins: data.origins,
      keywords: const [],
    );
    ref.read(allPossibleUnitsProvider.notifier).state = data.ingredientUnits;
    data.ingredientUnits.sort(alphabeticalStringSort);
    ref.read(allPossibleDifficultiesProvider.notifier).state = data.difficulties;
    
    prefs.setStringList("seasons_choices", data.seasons);
    prefs.setStringList("diets_choices", data.diets);
    prefs.setStringList("strengths_choices", data.strengths);
    prefs.setStringList("eras_choices", data.eras);
    prefs.setStringList("colors_choices", data.colors);
    prefs.setStringList("origins_choices", data.origins);
    prefs.setStringList("difficulties_choices", data.difficulties);
    prefs.setStringList("ingredient_units_choices", data.ingredientUnits);
  } else if (response is DataFailed) {
    ref.read(allPossibleCategoriesProvider.notifier).state = Categories(
      seasons: prefs.getStringList("seasons_choices") ?? [],
      diets: prefs.getStringList("diets_choices") ?? [],
      strengths: prefs.getStringList("strengths_choices") ?? [],
      eras: prefs.getStringList("eras_choices") ?? [],
      colors: prefs.getStringList("colors_choices") ?? [],
      origins: prefs.getStringList("origins_choices") ?? [],
      keywords: const [],
    );
    ref.read(allPossibleUnitsProvider.notifier).state = [];
    ref.read(allPossibleDifficultiesProvider.notifier).state = [];
  }
});